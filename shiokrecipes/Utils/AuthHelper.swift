//
//  AuthHelper.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 12/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit
import Firebase

class AuthHelper {
    static let shared = AuthHelper()
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if error != nil {
                Helper.app.showMessagePrompt(message: error!.localizedDescription)
                completion(false)
                return
            }
            
            print("\(email) has signed in successfully.")
            self.navigateToExploreScreen()
        }
        completion(true)
    }
    
    func logout(completion: @escaping (Bool) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            if firebaseAuth.currentUser == nil {
                print("User has signed out successfully.")
            }
            
            navigateToLoginScreen()
            completion(true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            completion(false)
        }
    }
    
    func signup(firstName: String, lastName: String, email: String, username: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let self = self else { return }
            
            guard let user = authResult?.user, error == nil else {
                Helper.app.showMessagePrompt(message: error!.localizedDescription)
                return
            }
            
            print("\(user.email!) created")
            
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).setData([
                "first_name": firstName,
                "last_name": lastName,
                "username": username
            ]) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                    completion(false)
                } else {
                    print("Document added with ID: \(user.uid)")
                    self.navigateToExploreScreen()
                    completion(true)
                }
            }
        }
    }
    
    func userIsLoggedIn() -> Bool {
        return (Auth.auth().currentUser != nil)
    }
    
    func navigateToExploreScreen() {
        if let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
            let navigationController = keyWindow.rootViewController as? UINavigationController {
            navigationController.viewControllers = [TabBarController.shared]
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    private func navigateToLoginScreen() {
        let loginVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: loginVc)
        navigationController.isNavigationBarHidden = true
        navigationController.isToolbarHidden = true
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}

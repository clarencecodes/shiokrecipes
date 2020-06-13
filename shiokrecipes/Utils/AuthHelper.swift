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
    
    func login(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                Helper.app.showMessagePrompt(message: error!.localizedDescription)
                return
            }
            self.navigateToExploreScreen()
        }
        
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            
            try firebaseAuth.signOut()
            
            if firebaseAuth.currentUser == nil {
                print("User has signed out successfully.")
            }
            
            let loginVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
            let navigationController = UINavigationController(rootViewController: loginVc)
            navigationController.isNavigationBarHidden = true
            navigationController.isToolbarHidden = true
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func signup(firstName: String, lastName: String, email: String, username: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                Helper.app.showMessagePrompt(message: error!.localizedDescription)
                return
            }
            
            print("\(user.email!) created")
            self.navigateToExploreScreen()
        }
    }
    
    private func navigateToExploreScreen() {
        if let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
        let navigationController = keyWindow.rootViewController as? UINavigationController {
            let tabbarController = TabBarController()
            navigationController.viewControllers = [tabbarController]
            navigationController.popToRootViewController(animated: true)
        }
    }
    
}

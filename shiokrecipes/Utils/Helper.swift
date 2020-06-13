//
//  Helper.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 12/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit
import Firebase

class Helper {
    static let shared = Helper()
    
    func login(email: String, password: String) {
        guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
        let navigationController = keyWindow.rootViewController as? UINavigationController else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if error != nil {
                let alert = UIAlertController(title: "Oops!", message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                navigationController.present(alert, animated: true, completion: nil)
                return
            }
            
            let tabbarController = TabBarController()
            navigationController.viewControllers = [tabbarController]
            navigationController.popToRootViewController(animated: true)
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
    
}

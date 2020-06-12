//
//  Helper.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 12/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class Helper {
    static let shared = Helper()
    
    func login() {
        guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
            let navigationController = keyWindow.rootViewController as? UINavigationController else { return }
        
        let tabbarController = TabBarController()
        navigationController.viewControllers = [tabbarController]
        navigationController.popToRootViewController(animated: true)
    }
    
    func logout() {
        let loginVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: loginVc)
        navigationController.isNavigationBarHidden = true
        navigationController.isToolbarHidden = true
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

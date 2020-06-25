//
//  Extension+UIViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 25/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

fileprivate var activityView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.heightAnchor.constraint(equalToConstant: 80).isActive = true
    view.widthAnchor.constraint(equalToConstant: 80).isActive = true
    view.layer.cornerRadius = 10
    view.backgroundColor = .lightGray
    return view
}()

fileprivate var activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.color = .white
    indicator.startAnimating()
    return indicator
}()

extension UIViewController {
    func showSpinner() {
        DispatchQueue.main.async {
            activityView.addSubview(activityIndicator)
            self.view.addSubview(activityView)
            
            activityIndicator.centerXAnchor.constraint(equalTo: activityView.centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: activityView.centerYAnchor).isActive = true
            activityView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            activityView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            activityView.removeFromSuperview()
        }
    }
    
    func showAlert(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateToLoginScreen() {
        let loginVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: loginVc)
        navigationController.isNavigationBarHidden = true
        navigationController.isToolbarHidden = true
        self.view.window?.rootViewController = navigationController
        self.view.window?.makeKeyAndVisible()
    }
    
    func navigateToExploreScreen() {
        self.navigationController?.viewControllers = [TabBarController.shared]
        self.navigationController?.popToRootViewController(animated: true)
    }
}

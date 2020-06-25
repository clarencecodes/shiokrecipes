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
    
    func removeSpinner() {
        activityView.removeFromSuperview()
    }
}

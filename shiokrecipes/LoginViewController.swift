//
//  LoginViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 10/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel! {
        didSet {
            welcomeLabel.font = Constants.Design.Font.newYorkBold.withSize(24)
            welcomeLabel.text = Constants.Content.welcomeText
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            // Add line to bottom of textfield
            let line: UIView = {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.heightAnchor.constraint(equalToConstant: 1).isActive = true
                view.backgroundColor = .lightGray
                return view
            }()
            
            emailTextField.addSubview(line)
            NSLayoutConstraint.activate([
                line.bottomAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
                line.leftAnchor.constraint(equalTo: emailTextField.leftAnchor),
                line.rightAnchor.constraint(equalTo: emailTextField.rightAnchor)
            ])
            
            // Set the font and keyboard type for the textfield
            emailTextField.font = Constants.Design.Font.newYorkRegular.withSize(18)
            emailTextField.attributedPlaceholder = NSAttributedString(string: Constants.Content.emailOrUsername, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            emailTextField.keyboardType = .emailAddress
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            // Add line to bottom of textfield
            let line: UIView = {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.heightAnchor.constraint(equalToConstant: 1).isActive = true
                view.backgroundColor = .lightGray
                return view
            }()
            
            passwordTextField.addSubview(line)
            NSLayoutConstraint.activate([
                line.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
                line.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor),
                line.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor)
            ])
            
            // Set the font and keyboard type for the textfield
            passwordTextField.font = Constants.Design.Font.newYorkRegular.withSize(18)
            passwordTextField.attributedPlaceholder = NSAttributedString(string: Constants.Content.password, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var forgotPasswordButton: UIButton! {
        didSet {
            forgotPasswordButton.titleLabel?.font = Constants.Design.Font.newYorkSemibold.withSize(13)
        }
    }
    
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.layer.cornerRadius = CGFloat(10)
            
            // Drop shadow effect
            signInButton.layer.shadowOffset = CGSize(width: 0, height: 10)
            signInButton.layer.shadowRadius = 20
            signInButton.layer.shadowOpacity = 1
            
            signInButton.titleLabel?.font = Constants.Design.Font.newYorkBold.withSize(18)
        }
    }
    
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.titleLabel?.font = Constants.Design.Font.newYorkBold.withSize(14)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

//
//  LoginViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 10/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = Constants.Design.Font.newYorkBold.withSize(24)
            titleLabel.text = Constants.Content.welcomeText
        }
    }
    
    @IBOutlet var textFields: [UITextField]! {
        didSet {
            for textField in textFields {
                // Add line to bottom of textfield
                let line: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.heightAnchor.constraint(equalToConstant: 1).isActive = true
                    view.backgroundColor = .white
                    return view
                }()
                
                textField.addSubview(line)
                NSLayoutConstraint.activate([
                    line.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 7),
                    line.leftAnchor.constraint(equalTo: textField.leftAnchor),
                    line.rightAnchor.constraint(equalTo: textField.rightAnchor)
                ])
                
                // Set the font and keyboard type for the textfield
                textField.font = Constants.Design.Font.newYorkMedium.withSize(18)
                
                var placeholderText = ""
                switch textField.tag {
                case 0:
                    placeholderText = Constants.Content.emailOrUsername
                    textField.keyboardType = .emailAddress
                case 1:
                    placeholderText = Constants.Content.password
                    textField.isSecureTextEntry = true
                default:
                    break
                }
                
                textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                textField.alpha = 0.6
                
                // Detect any changes within the textField
                textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            }
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
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    // MARK: - IBActions
    
    @IBAction func navigateToForgotPasswordScreen(_ sender: UIButton) {
        let vc = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        Helper.shared.login()
    }
    
    @IBAction func navigateToSignupScreen(_ sender: UIButton) {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Class methods
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.isEmpty {
            textField.alpha = 0.6
        } else {
            textField.alpha = 1
        }
    }
    
}

//
//  SignupViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 10/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = Constants.Design.Font.newYorkBold.withSize(24)
            titleLabel.text = Constants.Content.signUpGetStartedText
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
                
                // Set the font, placeholder text, and keyboard type for the textfield
                textField.font = Constants.Design.Font.newYorkMedium.withSize(18)
                
                var placeholderText = ""
                switch textField.tag {
                case 0:
                    placeholderText = "first name"
                case 1:
                    placeholderText = "last name"
                case 2:
                    placeholderText = "email"
                    textField.keyboardType = .emailAddress
                case 3:
                    placeholderText = "username"
                case 4:
                    placeholderText = "password"
                    textField.isSecureTextEntry = true
                case 5:
                    placeholderText = "confirm password"
                    textField.isSecureTextEntry = true
                default:
                    break
                }
                
                textField.attributedPlaceholder =  NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                textField.alpha = 0.7
            }
        }
    }
    @IBOutlet weak var signupButton: UIButton! {
        didSet {
            signupButton.layer.cornerRadius = CGFloat(10)
            
            // Drop shadow effect
            signupButton.layer.shadowOffset = CGSize(width: 0, height: 10)
            signupButton.layer.shadowRadius = 20
            signupButton.layer.shadowOpacity = 1
            
            signupButton.titleLabel?.font = Constants.Design.Font.newYorkBold.withSize(18)
        }
    }
    @IBOutlet weak var termsAndPrivacyLabel: UILabel! {
        didSet {
            termsAndPrivacyLabel.font = Constants.Design.Font.newYorkRegular.withSize(12)
        }
    }
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.titleLabel?.font = Constants.Design.Font.newYorkBold.withSize(14)
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    // MARK: - IBActions

    @IBAction func signInButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Class methods
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

//
//  SignupViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 10/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = Constants.Design.Font.newYorkBold.withSize(24)
            titleLabel.text = Constants.Strings.signUpGetStartedText
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
                    placeholderText = Constants.Strings.firstName
                case 1:
                    placeholderText = Constants.Strings.lastName
                case 2:
                    placeholderText = Constants.Strings.email
                    textField.keyboardType = .emailAddress
                case 3:
                    placeholderText = Constants.Strings.username
                case 4:
                    placeholderText = Constants.Strings.password
                    textField.isSecureTextEntry = true
                case 5:
                    placeholderText = Constants.Strings.confirmPassword
                    textField.isSecureTextEntry = true
                default:
                    break
                }
                
                textField.attributedPlaceholder =  NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                textField.alpha = 0.6
                
                // Detect any changes within the textField
                textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
    
    @IBOutlet weak var termsAndPrivacyTextView: UITextView! {
        didSet {
            let attributedString = NSMutableAttributedString(string: Constants.Strings.agreeToTerms)
            let rangeOfAttributedString = NSRange(location: 0, length: attributedString.length)
            
            // Set font and font color of attributed string
            attributedString.addAttribute(NSAttributedString.Key.font, value: Constants.Design.Font.newYorkRegular.withSize(12), range: rangeOfAttributedString)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: rangeOfAttributedString)
            
            // Set links for Terms and Conditions & Privacy Policy
            // TODO: change the terms and conditions & privacy policy URLs
            let range1 = (Constants.Strings.agreeToTerms as NSString).range(of: "Terms and Conditions")
            if range1.length > 0 {
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Constants.Design.Color.orange, range: range1)
                attributedString.addAttribute(NSAttributedString.Key.link, value: "https://google.com", range: range1)
            }
            
            let range2 = (Constants.Strings.agreeToTerms as NSString).range(of: "Privacy Policy.")
            if range2.length > 0 {
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Constants.Design.Color.orange, range: range2)
                attributedString.addAttribute(NSAttributedString.Key.link, value: "https://twitter.com", range: range2)
            }
            
            termsAndPrivacyTextView.attributedText = attributedString
            
            // Set color for links
            let linkAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: Constants.Design.Color.orange
            ]
            termsAndPrivacyTextView.linkTextAttributes = linkAttributes
        }
    }
    
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            // Set font of titleLabel
            signInButton.titleLabel?.font = Constants.Design.Font.newYorkBold.withSize(14)
            
            let attributedString = NSMutableAttributedString(string: Constants.Strings.alreadyHaveAccount)
            
            // Search for word occurrence
            let range = (Constants.Strings.alreadyHaveAccount as NSString).range(of: "Sign in")
            if range.length > 0 {
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Constants.Design.Color.orange, range: range)
            }
            
            // Set attributed text
            signInButton.titleLabel!.attributedText = attributedString
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    // MARK: - IBActions

    @IBAction func navigateBackToSignInScreen(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        
        // TODO: refactor this
        // do proper validation for all fields
        // after creating user, store the first name, last name, username into the DB
        // check that password == confirm password
        
        guard let firstName = textFields[0].text, !firstName.isEmpty else {
            self.showAlert(message: Constants.Strings.firstNameEmpty)
            return
        }
        
        guard let lastName = textFields[1].text, !lastName.isEmpty else {
            self.showAlert(message: Constants.Strings.lastNameEmpty)
            return
        }
        
        guard let email = textFields[2].text, !email.isEmpty else {
            self.showAlert(message: Constants.Strings.emailEmpty)
            return
        }
        
        guard let username = textFields[3].text, !username.isEmpty else {
            self.showAlert(message: Constants.Strings.usernameEmpty)
            return
        }
        
        guard let password = textFields[4].text, !password.isEmpty else {
            self.showAlert(message: Constants.Strings.passwordEmpty)
            return
        }
        
        guard let confirmPassword = textFields[5].text, password == confirmPassword else {
            self.showAlert(message: Constants.Strings.confirmPasswordMustMatchPassword)
            return
        }
        
        self.showSpinner()
        AuthHelper.shared.signup(
            firstName: firstName,
            lastName: lastName,
            email: email,
            username: username,
            password: password) { [weak self] (success) in
                guard let self = self else { return }
                self.hideSpinner()
                if success {
                    AuthHelper.shared.navigateToExploreScreen()
                }
        }
        
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
    
    // MARK: - Validation
    
    
    
}

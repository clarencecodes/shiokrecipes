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
                    placeholderText = Constants.Content.firstName
                case 1:
                    placeholderText = Constants.Content.lastName
                case 2:
                    placeholderText = Constants.Content.email
                    textField.keyboardType = .emailAddress
                case 3:
                    placeholderText = Constants.Content.username
                case 4:
                    placeholderText = Constants.Content.password
                    textField.isSecureTextEntry = true
                case 5:
                    placeholderText = Constants.Content.confirmPassword
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

    @IBAction func navigateBackToSignInScreen(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        
        // TODO: refactor this
        // do proper validation for all fields
        // after creating user, store the first name, last name, username into the DB
        // check that password == confirm password
        
        guard let email = textFields[2].text, !email.isEmpty else {
            let alert = UIAlertController(title: "Oops!", message: "Email can't be empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let password = textFields[4].text, !password.isEmpty else {
            let alert = UIAlertController(title: "Oops!", message: "Password can't be empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                let alert = UIAlertController(title: "Oops!", message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            print("\(user.email!) created")
            Helper.shared.login()
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
    
}

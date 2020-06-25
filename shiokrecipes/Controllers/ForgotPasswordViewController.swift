//
//  ForgotPasswordViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 11/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = Constants.Design.Font.newYorkBold.withSize(24)
            titleLabel.text = Constants.Strings.forgotPasswordTitle1
        }
    }
    
    @IBOutlet weak var title2Label: UILabel! {
        didSet {
            title2Label.font = Constants.Design.Font.newYorkBold.withSize(18)
            title2Label.text = Constants.Strings.forgotPasswordTitle2
        }
    }
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            // Add line to bottom of textfield
            let line: UIView = {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.heightAnchor.constraint(equalToConstant: 1).isActive = true
                view.backgroundColor = .white
                return view
            }()
            
            emailTextField.addSubview(line)
            NSLayoutConstraint.activate([
                line.bottomAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 7),
                line.leftAnchor.constraint(equalTo: emailTextField.leftAnchor),
                line.rightAnchor.constraint(equalTo: emailTextField.rightAnchor)
            ])
            
            // Set the font and keyboard type for the textfield
            emailTextField.font = Constants.Design.Font.newYorkMedium.withSize(18)
            
            emailTextField.attributedPlaceholder = NSAttributedString(string: Constants.Strings.email, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            emailTextField.keyboardType = .emailAddress
            emailTextField.alpha = 0.6
            
            // Detect any changes within the textField
            emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = CGFloat(10)
            
            // Drop shadow effect
            nextButton.layer.shadowOffset = CGSize(width: 0, height: 10)
            nextButton.layer.shadowRadius = 20
            nextButton.layer.shadowOpacity = 1
            
            nextButton.titleLabel?.font = Constants.Design.Font.newYorkBold.withSize(18)
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        guard let email = emailTextField.text, !email.isEmpty else {
            return
        }
        
        self.showSpinner()
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            guard let self = self else { return }
            
            self.hideSpinner()
            
            if let error = error {
                Helper.app.showMessagePrompt(message: error.localizedDescription)
            } else {
                let alert = UIAlertController(title: Constants.Strings.resetPassword,
                                              message: Constants.Strings.checkEmailToResetPassword,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Class methods

    @objc private func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.isEmpty {
            textField.alpha = 0.6
        } else {
            textField.alpha = 1
        }
    }
}

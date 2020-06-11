//
//  ForgotPasswordViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 11/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = Constants.Design.Font.newYorkBold.withSize(24)
            titleLabel.text = Constants.Content.forgotPasswordTitle1
        }
    }
    
    @IBOutlet weak var title2Label: UILabel! {
        didSet {
            title2Label.font = Constants.Design.Font.newYorkBold.withSize(18)
            title2Label.text = Constants.Content.forgotPasswordTitle2
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
            
            emailTextField.attributedPlaceholder = NSAttributedString(string: Constants.Content.email, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
        print("nextButtonTapped")
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

//
//  AddRecipeViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 26/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var addRecipeTitleLabel: UILabel! {
        didSet {
            addRecipeTitleLabel.font = Constants.Design.Font.newYorkBold.withSize(36)
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = recipe.image
        }
    }
    
    @IBOutlet weak var dishNameLabel: UILabel! {
        didSet {
            dishNameLabel.font = Constants.Design.Font.newYorkSemibold.withSize(18)
        }
    }
    
    @IBOutlet weak var dishNameTextField: UITextField! {
        didSet {
            dishNameTextField.backgroundColor = .clear
            dishNameTextField.layer.borderColor = UIColor.lightGray.cgColor
            dishNameTextField.layer.borderWidth = 1
            dishNameTextField.layer.cornerRadius = 5
            dishNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 2))
            dishNameTextField.leftViewMode = .always
            
            dishNameTextField.font = Constants.Design.Font.newYorkRegular.withSize(13)
        }
    }
    
    @IBOutlet weak var aboutRecipeLabel: UILabel! {
        didSet {
            aboutRecipeLabel.font = Constants.Design.Font.newYorkSemibold.withSize(18)
        }
    }
    
    @IBOutlet weak var aboutRecipeTextView: UITextView! {
        didSet {
            aboutRecipeTextView.backgroundColor = .clear
            aboutRecipeTextView.layer.borderColor = UIColor.lightGray.cgColor
            aboutRecipeTextView.layer.borderWidth = 1
            aboutRecipeTextView.layer.cornerRadius = 5
            
            aboutRecipeTextView.font = Constants.Design.Font.newYorkRegular.withSize(13)
        }
    }
    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = CGFloat(10)
            
            nextButton.titleLabel?.font = Constants.Design.Font.newYorkBold.withSize(18)
        }
    }
    
    // MARK: - Properties
    
    var recipe: Recipe!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - IBActions
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: Constants.Strings.saveRecipeDraftTitle + "?", message: Constants.Strings.saveRecipeDraftMessage, preferredStyle: .alert)
        let discardAction = UIAlertAction(title: Constants.Strings.discardRecipe, style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            print("discard recipe")
            self.dismiss(animated: true, completion: nil)
        }
        let saveDraftAction = UIAlertAction(title: Constants.Strings.saveRecipeDraftTitle, style: .default) { _ in
            print("save recipe as draft")
        }
        alert.addAction(discardAction)
        alert.addAction(saveDraftAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        print("nextButtonTapped")
        let vc = AddRecipeIngredientsViewController(nibName: "AddRecipeIngredientsViewController", bundle: nil)
        vc.recipe = self.recipe
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

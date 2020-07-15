//
//  AddRecipeIngredientsViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 5/7/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class AddRecipeIngredientsViewController: UIViewController {

    // MARK: - Properties
    
    private var prepTime = 30
    private var cookTime = 15
    private var ingredients = ["", "", "", "", ""]
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var addRecipeTitleLabel: UILabel! {
        didSet {
            addRecipeTitleLabel.font = Constants.Design.Font.newYorkBold.withSize(36)
        }
    }
    
    @IBOutlet weak var timeNeededLabel: UILabel! {
        didSet {
            timeNeededLabel.font = Constants.Design.Font.newYorkSemibold.withSize(18)
        }
    }
    
    @IBOutlet weak var prepLabel: UILabel!
    
    @IBOutlet weak var prepTimeButton: UIButton! {
        didSet {
            prepTimeButton.layer.cornerRadius = prepTimeButton.frame.height / 2
            prepTimeButton.layer.borderColor = UIColor.lightGray.cgColor
            prepTimeButton.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var cookLabel: UILabel!
    @IBOutlet weak var cookTimeButton: UIButton! {
        didSet {
            cookTimeButton.layer.cornerRadius = cookTimeButton.frame.height / 2
            cookTimeButton.layer.borderColor = UIColor.lightGray.cgColor
            cookTimeButton.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var ingredientsNeededLabel: UILabel! {
        didSet {
            ingredientsNeededLabel.font = Constants.Design.Font.newYorkSemibold.withSize(18)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(IngredientTextFieldCell.self, forCellReuseIdentifier: "IngredientTextFieldCell")
            tableView.register(AddIngredientCell.self, forCellReuseIdentifier: "AddIngredientCell")
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.layer.cornerRadius = CGFloat(10)
            backButton.layer.borderColor = UIColor.lightGray.cgColor
            backButton.layer.borderWidth = 1
            
            backButton.titleLabel?.font = Constants.Design.Font.newYorkBold.withSize(18)
            backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        }
    }
    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = CGFloat(10)
            nextButton.backgroundColor = Constants.Design.Color.orange
            
            nextButton.titleLabel?.font = Constants.Design.Font.newYorkBold.withSize(18)
            nextButton.titleLabel?.textAlignment = .left
            nextButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
            
            nextButton.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
            nextButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 85, bottom: 0, right: 0)
        }
    }
    
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Class methods
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
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
        let vc = AddRecipeDirectionsViewController(nibName: "AddRecipeDirectionsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func prepTimeButtonTapped(_ sender: UIButton) {
        print("prepTimeButtonTapped")
    }
    
    @IBAction func cookTimeButtonTapped(_ sender: UIButton) {
        print("cookTimeButtonTapped")
    }
    
    
    
}

// MARK: - UITableViewDelegate/DataSource
extension AddRecipeIngredientsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == ingredients.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddIngredientCell") as! AddIngredientCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTextFieldCell") as! IngredientTextFieldCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == ingredients.count {
            print("last row selected")
            ingredients.append("")
            
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath.init(row: ingredients.count - 1, section: 0)], with: .automatic)
            tableView.endUpdates()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                tableView.scrollToRow(at: IndexPath.init(row: self.ingredients.count, section: 0), at: .none, animated: true)
            }
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension AddRecipeIngredientsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: tableView) ?? false {
            return false
        }
        
        return true
    }
}

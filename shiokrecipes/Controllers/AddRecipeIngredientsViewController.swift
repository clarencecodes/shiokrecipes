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
    
    var recipe: Recipe!
    
    private let prepTimePicker = UIPickerView()
    private let cookTimePicker = UIPickerView()
    
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
    
    @IBOutlet weak var prepTimeTextField: UITextField! {
        didSet {
            prepTimeTextField.layer.cornerRadius = prepTimeTextField.frame.height / 2
            prepTimeTextField.layer.borderColor = UIColor.lightGray.cgColor
            prepTimeTextField.layer.borderWidth = 1
            
            // Hide the textField's blinking cursor
            prepTimeTextField.tintColor = .clear
            
            prepTimeTextField.text = "\(self.recipe.prepTimeInMinutes) min"
            prepTimeTextField.inputView = prepTimePicker
        }
    }
    
    @IBOutlet weak var cookLabel: UILabel!
    
    @IBOutlet weak var cookTimeTextField: UITextField! {
        didSet {
            cookTimeTextField.layer.cornerRadius = cookTimeTextField.frame.height / 2
            cookTimeTextField.layer.borderColor = UIColor.lightGray.cgColor
            cookTimeTextField.layer.borderWidth = 1
            
            // Hide the textField's blinking cursor
            cookTimeTextField.tintColor = .clear
            
            cookTimeTextField.text = "\(self.recipe.cookTimeInMinutes) min"
            cookTimeTextField.inputView = cookTimePicker
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
            tableView.register(AddButtonCell.self, forCellReuseIdentifier: "AddButtonCell")
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
        
        prepTimePicker.delegate = self
        prepTimePicker.dataSource = self
        prepTimePicker.selectRow(5, inComponent: 0, animated: false) // Set default prep time to 30 min
        
        cookTimePicker.delegate = self
        cookTimePicker.dataSource = self
        cookTimePicker.selectRow(2, inComponent: 0, animated: false) // Set default cook time to 15 min
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
        vc.recipe = recipe
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: - UITableViewDelegate/DataSource
extension AddRecipeIngredientsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingredients.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == recipe.ingredients.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonCell") as! AddButtonCell
            cell.label.text = "Add ingredient"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTextFieldCell") as! IngredientTextFieldCell
        cell.textField.delegate = self
        cell.textField.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == recipe.ingredients.count {
            print("last row selected")
            recipe.ingredients.append("")
            
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath.init(row: recipe.ingredients.count - 1, section: 0)], with: .automatic)
            tableView.endUpdates()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                tableView.scrollToRow(at: IndexPath.init(row: self.recipe.ingredients.count, section: 0), at: .none, animated: true)
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

// MARK: - UITextFieldDelegate
extension AddRecipeIngredientsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        recipe.ingredients[textField.tag] = textField.text ?? ""
    }
}


// MARK: - UIPickerViewDelegate & DataSource
extension AddRecipeIngredientsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 24
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format: "%2d min", (row+1)*5)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case prepTimePicker:
            prepTimeTextField.text = String(format: "%2d min", (row+1)*5)
        case cookTimePicker:
            cookTimeTextField.text = String(format: "%2d min", (row+1)*5)
        default:
            break
        }
    }
    
}

//
//  AddRecipeDirectionsViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 14/7/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit
import Firebase

class AddRecipeDirectionsViewController: UIViewController {

    // MARK: - Properties
    
    var recipe: Recipe!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var addRecipeTitleLabel: UILabel! {
        didSet {
            addRecipeTitleLabel.font = Constants.Design.Font.newYorkBold.withSize(36)
        }
    }
    
    @IBOutlet weak var directionsLabel: UILabel! {
        didSet {
            directionsLabel.font = Constants.Design.Font.newYorkSemibold.withSize(18)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(RecipeDirectionTextViewCell.self, forCellReuseIdentifier: "RecipeDirectionTextViewCell")
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
    
    @IBOutlet weak var addRecipeButton: UIButton! {
        didSet {
            addRecipeButton.backgroundColor = Constants.Design.Color.orange
            addRecipeButton.layer.cornerRadius = CGFloat(10)
            
            addRecipeButton.titleLabel?.font = Constants.Design.Font.newYorkBold.withSize(18)
        }
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
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addRecipeButtonTapped(_ sender: UIButton) {
        print("addRecipeButtonTapped")
        // Filter out empty strings within recipe ingredients and directions
        recipe.ingredients = recipe.ingredients.filter({ !$0.isEmpty })
        recipe.directions = recipe.directions.filter({ !$0.isEmpty })
        
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("recipes").addDocument(data: [
            // TODO: add recipe image data to Firestore
            "name": self.recipe.name,
            "description": self.recipe.description,
            "prep_time_in_minutes": self.recipe.prepTimeInMinutes,
            "cook_time_in_minutes": self.recipe.cookTimeInMinutes,
            "ingredients": self.recipe.ingredients,
            "directions": self.recipe.directions,
            "author": Auth.auth().currentUser!.displayName!,
            "user_id": Auth.auth().currentUser!.uid
        ]) { error in
            if let error = error {
                print("Error adding recipe: \(error)")
            } else {
                print("Recipe added with ID: \(ref!.documentID)")
                self.dismiss(animated: true, completion: nil)
            }
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

}

// MARK: - UIGestureRecognizerDelegate
extension AddRecipeDirectionsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: tableView) ?? false {
            return false
        }
        
        return true
    }
}

// MARK: - UITableViewDelegate/DataSource
extension AddRecipeDirectionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.directions.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == recipe.directions.count {
            return 50
        }
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == recipe.directions.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonCell") as! AddButtonCell
            cell.label.text = "Add step"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDirectionTextViewCell") as! RecipeDirectionTextViewCell
        cell.stepLabel.text = "STEP \(indexPath.row + 1)"
        cell.textView.delegate = self
        cell.textView.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == recipe.directions.count {
            print("last row selected")
            recipe.directions.append("")
            
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath.init(row: recipe.directions.count - 1, section: 0)], with: .automatic)
            tableView.endUpdates()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                tableView.scrollToRow(at: IndexPath.init(row: self.recipe.directions.count, section: 0), at: .none, animated: true)
            }
        }
    }
    
}

// MARK: - UITextViewDelegate
extension AddRecipeDirectionsViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        recipe.directions[textView.tag] = textView.text
    }
}

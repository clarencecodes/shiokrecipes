//
//  AddRecipeDirectionsViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 14/7/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

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
        // TODO: make Firebase API call here
        print(recipe as Any)
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}

// MARK: - UITableViewDelegate/DataSource
extension AddRecipeDirectionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 50
        }
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonCell") as! AddButtonCell
            cell.label.text = "Add step"
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDirectionTextViewCell") as! RecipeDirectionTextViewCell
        cell.stepLabel.text = "STEP \(indexPath.row + 1)"
        return cell
    }
    
    
}
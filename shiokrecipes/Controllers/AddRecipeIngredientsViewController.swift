//
//  AddRecipeIngredientsViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 5/7/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class AddRecipeIngredientsViewController: UIViewController {

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
    @IBOutlet weak var cookLabel: UILabel!
    @IBOutlet weak var ingredientsNeededLabel: UILabel! {
        didSet {
            ingredientsNeededLabel.font = Constants.Design.Font.newYorkSemibold.withSize(18)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(IngredientTextFieldCell.self, forCellReuseIdentifier: "IngredientTextFieldCell")
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension AddRecipeIngredientsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTextFieldCell") as! IngredientTextFieldCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

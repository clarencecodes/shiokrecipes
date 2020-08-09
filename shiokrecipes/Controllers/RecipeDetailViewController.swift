//
//  RecipeDetailViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 9/8/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: - Properties
    
    var recipe = Recipe()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(RecipeDetailDescriptionCell.self, forCellReuseIdentifier: "RecipeDetailDescriptionCell")
    }

}


// MARK: - UITableViewDelegate and DataSource

extension RecipeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.recipe.ingredients.count
        case 2:
            return self.recipe.directions.count
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: RecipeDetailDescriptionCell!
            cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailDescriptionCell") as? RecipeDetailDescriptionCell
            cell.dishNameLabel.text = self.recipe.name
            cell.dishImageView.image = self.recipe.image
            cell.authorNameLabel.text = self.recipe.author
            cell.descriptionLabel.text = self.recipe.description
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 518
    }
}

//
//  AddRecipeDirectionsViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 14/7/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class AddRecipeDirectionsViewController: UIViewController {

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

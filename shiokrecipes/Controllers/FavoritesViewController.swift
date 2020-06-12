//
//  FavoritesViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 12/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class FavoritesViewController: RecipeViewController {
    convenience init() {
        self.init(nibName: "RecipeViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        self.titleLabel.text = "Favorites"
        self.view.backgroundColor = Constants.Design.Color.red
    }
}

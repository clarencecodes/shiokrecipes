//
//  RecipeViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 11/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = Constants.Design.Font.newYorkBold.withSize(36)
            titleLabel.textColor = .white
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            
            collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: "RecipeCollectionViewCell")
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

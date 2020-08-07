//
//  ExploreViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 12/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class ExploreViewController: RecipeViewController {
    convenience init() {
        self.init(nibName: "RecipeViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        self.titleLabel.text = "Explore"
        self.view.backgroundColor = Constants.Design.Color.orange
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}


// MARK: - CollectionViewDelegates & DataSource

extension RecipeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RecipeCollectionViewCell
        
        cell.authorNameLabel.text = "Jamie Oliver"
        cell.titleLabel.text = "Pancakes with strawberries and blueberries"
        
        DispatchQueue.main.async {
            if let url = URL(string: "https://images.unsplash.com/photo-1528207776546-365bb710ee93?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&dpr=2&auto=format&fit=crop&w=140&h=200&q=60"),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                cell.dishImageView.image = image
            }
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 2) - 28
        let height = 1.65 * width
        return CGSize(width: width, height: height)
    }
    
}

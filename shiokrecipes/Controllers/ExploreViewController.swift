//
//  ExploreViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 12/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit
import Firebase

class ExploreViewController: RecipeViewController {
    
    // MARK: - Properties
    private var recipes = [Recipe]()
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(nibName: "RecipeViewController", bundle: nil)
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        self.titleLabel.text = "Explore"
        self.view.backgroundColor = Constants.Design.Color.orange
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Download recipes from Firebase
        
        let db = Firestore.firestore()
        db.collection("recipes")
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting recipes: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let documentID = document.documentID
                    
                    let imagePathRef = Storage.storage().reference(withPath: "recipe_images/\(documentID)")
                    imagePathRef.downloadURL { (url, error) in
                        if let error = error {
                            print(error)
                        } else {
                            var recipe = Recipe()
                            let data = document.data()
                            recipe.name = data["name"] as! String
                            recipe.imageUrl = url
                            recipe.author = data["author"] as! String
                            recipe.description = data["description"] as! String
                            recipe.ingredients = data["ingredients"] as! [String]
                            recipe.directions = data["directions"] as! [String]
                            recipe.cookTimeInMinutes = data["cook_time_in_minutes"] as! Int
                            recipe.prepTimeInMinutes = data["prep_time_in_minutes"] as! Int
                            
                            self.recipes.append(recipe)
                            
                            if self.recipes.count == querySnapshot!.documents.count {
                                self.collectionView.reloadData()
                            }
                            
                        }
                    }
                    
                    
                }
            }
        }
    }
}


// MARK: - CollectionViewDelegates & DataSource

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RecipeCollectionViewCell
        let recipe = recipes[indexPath.row]
        
        cell.authorNameLabel.text = recipe.author
        cell.titleLabel.text = recipe.name
        
        DispatchQueue.main.async {
            if let url = recipe.imageUrl,
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

//
//  TabBarController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 12/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    static let shared = TabBarController()
    
    let exploreTabBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "Explore"
        item.image = UIImage(systemName: "magnifyingglass")
        item.selectedImage = UIImage(systemName: "magnifyingglass",
                                     withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .bold))?
            .withRenderingMode(.alwaysOriginal)
        return item
    }()
    
    let myRecipesTabBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "My Recipes"
        item.image = UIImage(systemName: "doc.text")
        item.selectedImage = UIImage(systemName: "doc.text.fill")
        return item
    }()
    
    let addTabBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = nil
        // TODO: fix issue where image is aligned too much on top
        item.image = UIImage(systemName: "plus.app",
                             withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
        return item
    }()
    
    let favoritesTabBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "Favorites"
        item.image = UIImage(systemName: "heart")
        item.selectedImage = UIImage(systemName: "heart.fill")
        return item
    }()
    
    let settingsTabBarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "Settings"
        item.image = UIImage(systemName: "gear",
                             withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .regular))
        return item
    }()
    
    let exploreVc = ExploreViewController()
    let myRecipesVc = MyRecipesViewController()
    let addVc = UIViewController()
    let favoritesVc = FavoritesViewController()
    let settingsVc = SettingsViewController()
    
    override func viewDidLoad() {
        delegate = self
        
        exploreVc.tabBarItem = exploreTabBarItem
        myRecipesVc.tabBarItem = myRecipesTabBarItem
        addVc.tabBarItem = addTabBarItem
        favoritesVc.tabBarItem = favoritesTabBarItem
        settingsVc.tabBarItem = settingsTabBarItem
        
        self.viewControllers = [exploreVc, myRecipesVc, addVc, favoritesVc, settingsVc]
        self.tabBar.tintColor = .black
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == settingsTabBarItem {
            // Present a new instance of SettingsViewController instead of using the above `settingsVc`.
            // This prevents an exception - "Application tried to present modally an active controller" from happening
            let vc = SettingsViewController()
            vc.delegate = self
            let navigationController = UINavigationController(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)
        } else if item == addTabBarItem {
            self.showImagePickerControllerActionSheet()
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == settingsVc {
            let selectedImage = UIImage(systemName: "gear",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .bold))?
                .withRenderingMode(.alwaysOriginal)
            
            settingsVc.tabBarItem.image = selectedImage
            return false
        } else if viewController == addVc {
            return false
        }
        return true
    }
}

// MARK: - SettingsViewControllerDelegate

extension TabBarController: SettingsViewControllerDelegate {
    func didDismissSettingsModal() {
        settingsVc.tabBarItem.image = UIImage(systemName: "gear")
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension TabBarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePickerControllerActionSheet() {
        let actionSheet = UIAlertController(title: "Add a recipe", message: Constants.Strings.uploadDishPhoto, preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Choose from Library", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.showImagePickerController(sourceType: .photoLibrary)
        })
        let cameraAction = UIAlertAction(title: "Take a new photo", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.showImagePickerController(sourceType: .camera)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true)
        } else {
            if sourceType == .camera {
                self.showAlert(title: Constants.Strings.oopsAlertTitle, message: Constants.Strings.noCameraAvailable)
            } else if sourceType == .photoLibrary {
                self.showAlert(title: Constants.Strings.oopsAlertTitle, message: Constants.Strings.noPhotoLibraryAvailable)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var image: UIImage!
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            print("edited image")
            image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("original image")
            image = originalImage
        }
        
        self.dismiss(animated: true, completion: {
            let vc = AddRecipeViewController(nibName: "AddRecipeViewController", bundle: nil)
            vc.dishImage = image
            
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .overFullScreen
            navigationController.navigationBar.isHidden = true
            
            self.present(navigationController, animated: true)
        })
    }
}

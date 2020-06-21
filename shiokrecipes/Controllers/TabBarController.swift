//
//  TabBarController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 12/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
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
    let favoritesVc = FavoritesViewController()
    let settingsVc = SettingsViewController()
    
    override func viewDidLoad() {
        delegate = self
        
        exploreVc.tabBarItem = exploreTabBarItem
        myRecipesVc.tabBarItem = myRecipesTabBarItem
        favoritesVc.tabBarItem = favoritesTabBarItem
        settingsVc.tabBarItem = settingsTabBarItem
        
        self.viewControllers = [exploreVc, myRecipesVc, favoritesVc, settingsVc]
        self.tabBar.tintColor = .black
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == settingsTabBarItem {
            // Present a new instance of SettingsViewController instead of using the above `settingsVc`.
            // This prevents an exception - "Application tried to present modally an active controller" from happening
            let vc = SettingsViewController()
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == settingsVc {
            let selectedImage = UIImage(systemName: "gear",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .bold))?
                .withRenderingMode(.alwaysOriginal)
            
            settingsVc.tabBarItem.image = selectedImage
            return false
        }
        return true
    }
}

extension TabBarController: SettingsViewControllerDelegate {
    func didDismissSettingsModal() {
        settingsVc.tabBarItem.image = UIImage(systemName: "gear")
    }
}

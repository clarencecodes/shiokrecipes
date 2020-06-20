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
        item.image = UIImage(systemName: "gear")
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
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == settingsTabBarItem {
            // Present a new instance of SettingsViewController instead of using the above `settingsVc`.
            // This prevents an exception - "Application tried to present modally an active controller" from happening
            let vc = SettingsViewController()
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == settingsVc {
            let selectedImage = UIImage(systemName: "gear",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .black))?
                .withRenderingMode(.alwaysOriginal)
                .withBaselineOffset(fromBottom: 3)
            
            settingsVc.tabBarItem.image = selectedImage
            return false
        }
        return true
    }
}

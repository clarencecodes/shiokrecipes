//
//  TabBarController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 12/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        let exploreTabBarItem = UITabBarItem()
        exploreTabBarItem.title = "Explore"
        exploreTabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        let myRecipesTabBarItem = UITabBarItem()
        myRecipesTabBarItem.title = "My Recipes"
        myRecipesTabBarItem.image = UIImage(systemName: "doc.plaintext")
        
        let favoritesTabBarItem = UITabBarItem()
        favoritesTabBarItem.title = "Favorites"
        favoritesTabBarItem.image = UIImage(systemName: "heart")
        
        let settingsTabBarItem = UITabBarItem()
        settingsTabBarItem.title = "Settings"
        settingsTabBarItem.image = UIImage(systemName: "gear")
        
        let exploreVc = ExploreViewController()
        exploreVc.tabBarItem = exploreTabBarItem
        
        let myRecipesVc = MyRecipesViewController()
        myRecipesVc.tabBarItem = myRecipesTabBarItem
        
        let favoritesVc = FavoritesViewController()
        favoritesVc.tabBarItem = favoritesTabBarItem
        
        // TODO: replace this with the correct ViewController
        let settingsVc = UIViewController()
        settingsVc.tabBarItem = settingsTabBarItem
        
        self.viewControllers = [exploreVc, myRecipesVc, favoritesVc, settingsVc]
    }
    
    
}

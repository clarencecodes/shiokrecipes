//
//  Recipe.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 5/8/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

struct Recipe {
    var name: String
    var image: UIImage
    var imageUrl: URL?
    var description: String
    var prepTimeInMinutes: Int
    var cookTimeInMinutes: Int
    var ingredients: [String]
    var directions: [String]
    
    init() {
        self.name = ""
        self.image = UIImage()
        self.imageUrl = nil
        self.description = ""
        self.prepTimeInMinutes = 30
        self.cookTimeInMinutes = 15
        self.ingredients = Array<String>(repeating: "", count: 5)
        self.directions = Array<String>(repeating: "", count: 2)
    }
}

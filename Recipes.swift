//
//  Recipes.swift
//  CookWhat
//
//  Created by MCP 2015 on 06/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import Foundation
import CoreData

class Recipes: NSManagedObject {

    @NSManaged var duration: String
    @NSManaged var id: String
    @NSManaged var servings: String
    @NSManaged var title: String
    @NSManaged var method: String
    
    @NSManaged var photoPath: String
    
    @NSManaged var isFavourite: Bool
    @NSManaged var difficultyLevel: String
    
    @NSManaged var ingredients: Ingredients
    
 

}


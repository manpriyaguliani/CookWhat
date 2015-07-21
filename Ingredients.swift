//
//  Ingredients.swift
//  CookWhat
//
//  Created by MCP 2015 on 06/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import Foundation
import CoreData

class Ingredients: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var priority: String
    @NSManaged var quantity: String
    @NSManaged var unit: String
    @NSManaged var recipe: NSManagedObject

}

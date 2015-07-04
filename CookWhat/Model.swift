//
//  Model.swift
//  CookWhat
//
//  Created by MCP 2015 on 24/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class Model: NSManagedObject {
    
    @NSManaged var title: String
    @NSManaged var servings: String
   // @NSManaged var info: String
    
   
}

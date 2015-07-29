//
//  AddMethodToRecipeController.swift
//  CookWhat
//
//  Created by MCP 2015 on 28/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class AddMethodToRecipeController: UIViewController {

    var recipeTitle: String = ""
    
    var photoPath: String = ""
    
    var recipeIngredientList: [AvailableIngredients] = [AvailableIngredients]()
    
    var recipeDuration: String = ""
    
    var recipeServing: String = ""
    
    @IBOutlet weak var recipeMethod: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

    
    //***** saving recipe
    @IBAction func saveTapped(sender: AnyObject) {
        
        //Reference to AppDelegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        //Reference to Context
        let contxt:NSManagedObjectContext = appDel.managedObjectContext!
        
        let rec = NSEntityDescription.entityForName("Recipes" , inManagedObjectContext: contxt)
        let ingr = NSEntityDescription.entityForName("Ingredients" , inManagedObjectContext: contxt)
        
        
        //Create instance of data model
        var newRecipe = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
        //map properties
        
        newRecipe.title = recipeTitle
        newRecipe.servings = recipeServing
        newRecipe.method = recipeMethod.text
        newRecipe.duration = recipeDuration
        newRecipe.isFavourite = "true"
        newRecipe.photoPath = photoPath
        
        
        //save context
        contxt.save(nil)
        
        for item in recipeIngredientList
        {
  
            var ingredient = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
            ingredient.name = item.name
            ingredient.quantity = item.quantity
            ingredient.unit = item.unit
            ingredient.recipe = newRecipe
            //save context
            contxt.save(nil)
 
        }
        //navigate back to root Vc
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
    }

 

}

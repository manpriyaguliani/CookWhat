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
        println("photo title.....")
        println(photoPath)
        println(recipeIngredientList.count)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//        var ingredient = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        //var newIngredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        
        
        // UIImage recipeImage = "sampleImage.jpg" as UIImage;
        
        //  NSData dataImage = UIImageJPEGRepresentation(recipeImage, 0.0);
        
        
        
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
    println(item.name)
       var ingredient = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
    ingredient.name = item.name
    ingredient.quantity = item.quantity
    ingredient.unit = item.unit
    ingredient.recipe = newRecipe
    //save context
    contxt.save(nil)
   // ingredient = Ingredients()

        }
    
//        newIngredient.name = recipeIngredient1.text
//        newIngredient.priority = ingredientPriority1.text
//        newIngredient.quantity = quantity1.text
//        newIngredient.unit = unit1.text
//        newIngredient.recipe = newRecipe
//        
//        newIngredient2.name = "some ingredient"
//        newIngredient2.priority = "high"
//        newIngredient2.quantity = "10"
//        newIngredient2.unit = "ml"
//        newIngredient2.recipe = newRecipe
//        
        
        
//        println(newRecipe)
//        println(newIngredient)
//        println("..........")
//        println(newIngredient.recipe)
//        println("..........")
        
        
        
        
        //navigate back to root Vc
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
    }

 

}

//
//  AddRecipeViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 11/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class AddRecipeViewController: UIViewController {

    @IBOutlet weak var recipeTitleText: UITextField!
    @IBOutlet weak var recipeServingText: UITextField!
    
    @IBOutlet weak var recipeDuration: UITextField!
    
    @IBOutlet weak var recipeIngredient1: UITextField!
    @IBOutlet weak var recipeIngredient2: UITextField!
    
    @IBOutlet weak var quantity1: UITextField!
    @IBOutlet weak var quantity2: UITextField!
    
    @IBOutlet weak var unit1: UITextField!
    @IBOutlet weak var unit2: UITextField!
    
    @IBOutlet weak var ingredientPriority1: UITextField!
    @IBOutlet weak var ingredientPriority2: UITextField!
    
    @IBOutlet weak var recipeMethod: UITextView!
    
    var recipeTitle: String = ""
    var recipeServing: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addIngredients(sender: AnyObject) {
        
       // var my:UITextField = UITextField(frame: CGRectMake(0, 0, 10, 10))
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
            var newIngredient = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var newIngredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        

       // UIImage recipeImage = "sampleImage.jpg" as UIImage;
        
      //  NSData dataImage = UIImageJPEGRepresentation(recipeImage, 0.0);
        
        
        
            //map properties
            
            newRecipe.title = recipeTitleText.text
            newRecipe.servings = recipeServingText.text
            newRecipe.method = recipeMethod.text
            newRecipe.duration = recipeDuration.text
        
           newIngredient.name = recipeIngredient1.text
           newIngredient.priority = ingredientPriority1.text
           newIngredient.quantity = quantity1.text
           newIngredient.unit = unit1.text
           newIngredient.recipe = newRecipe
        
        newIngredient2.name = "some ingredient"
        newIngredient2.priority = "high"
        newIngredient2.quantity = "10"
        newIngredient2.unit = "ml"
        newIngredient2.recipe = newRecipe
        
        
       
            println(newRecipe)
            println(newIngredient)
        println("..........")
        println(newIngredient.recipe)
        println("..........")
        
        
        //save context
        contxt.save(nil)
        
        
        //navigate back to root Vc
        self.navigationController?.popToRootViewControllerAnimated(true)

        
    }

//    @IBAction func cancelTapped(sender: AnyObject) {
//        
//        self.navigationController?.popToRootViewControllerAnimated(true)
//        
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

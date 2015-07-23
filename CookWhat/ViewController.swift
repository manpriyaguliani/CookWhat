//
//  ViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 10/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

// used for viewing recipes
class ViewController: UIViewController {

    var recipeTitle: String = ""
    var recipeServings: String = ""
    //var info: String = ""
    
    //test test
    //test test

    
    @IBOutlet weak var lblServings: UILabel!
    @IBOutlet weak var stpServings: UIStepper!
    
    @IBOutlet weak var segmentExpertise: UISegmentedControl!
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var servingsText: UITextField!
    
   // var existingItem: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   /*     if (existingItem != nil){
            titleText.text = recipeTitle
            servingsText.text = recipeServings
            //textFieldQuantity.text = quantity
        }*/
        loadData()
        
        
        if(lblServings != nil){
            lblServings.text = "1"
        }
        if(stpServings != nil){
            stpServings.minimumValue = 1
        }
    }
    
    func loadData()
    {
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
        
        
        
        //map properties
        
        newRecipe.title = "Test Recipe"
        newRecipe.servings = "Some serving"
        newRecipe.method = "Some method"
        newRecipe.duration = "Some duration"
        
        newIngredient.name = "Some ingredient 1"
        newIngredient.priority = "priority 1"
        newIngredient.quantity = "quantity"
        newIngredient.unit = "unit"
        newIngredient.recipe = newRecipe
        
        newIngredient2.name = "some ingredient 2"
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
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onValueChange(sender: UIStepper, forEvent event: UIEvent) {
        lblServings.text = Int(stpServings.value).description
    }
    


}


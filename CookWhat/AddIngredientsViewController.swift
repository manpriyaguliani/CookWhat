//
//  AddIngredientsViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 11/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class AddIngredientsViewController: UIViewController {
    
    
    @IBOutlet weak var isSavedLbl: UILabel!
    
    @IBOutlet weak var ingredientName: UITextField!
    @IBOutlet weak var stpQuantity: UIStepper!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var ingredientUnit: UITextField!
    
    var name: String = ""
    var quantity: String = ""
    var unit: String = ""
    
    var existingItem: NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isSavedLbl.hidden = true;
        
        if (existingItem != nil){
            ingredientName.text = name
            txtQuantity.text = quantity
            stpQuantity.value = Double(quantity.toInt()!)
            ingredientUnit.text = unit
            self.title = "Change Ingredient"

        }
        else
        {
        
            ingredientName.text = ""
            txtQuantity.text = ""
            stpQuantity.value = 0
            ingredientUnit.text = ""
            self.title = "Add Ingredient"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(didAppear: Bool) {
        super.viewDidAppear(didAppear)
        isSavedLbl.hidden = true;
    }
    
    //stepper UI Control
    @IBAction func onValueChange(sender: UIStepper, forEvent event: UIEvent) {
        txtQuantity.text = Int(stpQuantity.value).description
        
    }
    
    //to hide keyboard on screen
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        
        //Reference to AppDelegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        //Reference to Context
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let ingredient = NSEntityDescription.entityForName("AvailIngredients" , inManagedObjectContext: context)
        
        
        //check if ingredient exists
        
        if (existingItem != nil){
            existingItem.setValue(ingredientName.text, forKey: "name")
            existingItem.setValue(txtQuantity.text, forKey: "quantity")
            existingItem.setValue(ingredientUnit.text, forKey: "unit")
        }
        else {
        
        
        //Create instance of data model
        var newIngredient = AvailIngredients(entity:ingredient!, insertIntoManagedObjectContext: context)
        
        
        //map properties
        newIngredient.name = ingredientName.text
        newIngredient.quantity = txtQuantity.text
        newIngredient.unit = ingredientUnit.text
        
        println(newIngredient)
        }
        
        //save context
        context.save(nil)
        isSavedLbl.text = "Ingredient Saved"
        isSavedLbl.hidden = false;
        //navigate back to root Vc
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
    }
}

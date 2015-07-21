//
//  AddIngredientsViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 11/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class AddIngredientsViewController: UIViewController, UIPickerViewDelegate {

    var units = [ "Kilogram", "Gram" ,"Litre"]
    @IBOutlet weak var isSavedLbl: UILabel!
    
    @IBOutlet weak var ingredientName: UITextField!
    @IBOutlet weak var stpQuantity: UIStepper!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var ingredientUnit: UITextField!
    
    @IBOutlet weak var ingredientUnitLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isSavedLbl.hidden = true;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onValueChange(sender: UIStepper, forEvent event: UIEvent) {
        txtQuantity.text = Int(stpQuantity.value).description
        
    }

  
    @IBAction func saveTapped(sender: AnyObject) {
        
        //Reference to AppDelegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        //Reference to Context
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        let ingredient = NSEntityDescription.entityForName("AvailIngredients" , inManagedObjectContext: context)
        
        
        //Create instance of data model
        var newIngredient = AvailIngredients(entity:ingredient!, insertIntoManagedObjectContext: context)
        
        
        //map properties
        newIngredient.name = ingredientName.text
        newIngredient.quantity = txtQuantity.text
        newIngredient.unit = ingredientUnit.text
        
        println(newIngredient)
        

        //save context
        context.save(nil)
        
        ingredientName.text = ""
        ingredientUnit.text = ""
        txtQuantity.text = ""
        stpQuantity.value = 0
        
        isSavedLbl.text = "Ingredient Saved"
        isSavedLbl.hidden = false;
        
        
        //navigate back to root Vc
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return units.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return units[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
// code needs to be added here for selection
    }
    
}

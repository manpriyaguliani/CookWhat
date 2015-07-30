//
//  AddIngredientsToRecipeViewController.swift
//  CookWhat
//
//  Created by MCP 2015 on 24/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData


class AddIngredientsToRecipeViewController: UIViewController, UITableViewDataSource{

    //Locals
    var recipeTitle: String = ""
    
    var photoPath: String = ""
    
    var recipeDuration: String = ""
    
    var recipeServing: String = ""
    
    var recipeIngredientList: [AvailableIngredients] = [AvailableIngredients]()
      var list: [String] = []
    
    //Field Outlets
    
    @IBOutlet weak var quantityStepper: UIStepper!
    
    @IBOutlet weak var ingredientAddedTable: UITableView!
  
    @IBOutlet weak var ingredientName: UITextField!
    
    @IBOutlet weak var ingreditentQuantity: UITextField!
        
    
    @IBOutlet weak var ingredientUnit: UITextField!
    
    @IBOutlet weak var addBtn: UIButton!
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientAddedTable.dataSource = self
        ingreditentQuantity.text = "1"
       quantityStepper.minimumValue = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //to hide keyboard on screen
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
    }
    
 
    //Value on change event for quantity
    @IBAction func onValueChangeQuantityStepper(sender: AnyObject) {
        ingreditentQuantity.text = Int(quantityStepper.value).description
    }
    
    
    // On click event for Add
    @IBAction func onAddBtnClick(sender: AnyObject) {
        
        list.append(ingredientName.text)
        
        var avIng: AvailableIngredients = AvailableIngredients();
        
        
        avIng.name = ingredientName.text
        avIng.quantity = ingreditentQuantity.text
        avIng.unit = ingredientUnit.text
        recipeIngredientList.append(avIng)
        avIng = AvailableIngredients();
        
        sender.resignFirstResponder()
        
        
        ingredientAddedTable.reloadData()
        ingredientName.text = ""
        ingreditentQuantity.text = "1"
        ingredientUnit.text = ""
        quantityStepper.value = quantityStepper.minimumValue 
        
    }
    
    func textFieldShouldReturn(button: UIButton) -> Bool {
        
        button.resignFirstResponder()
        
        return true
    }
    
    //Data Source function Override
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeIngredientList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath) as! UITableViewCell
        
        
        var data: AvailableIngredients = recipeIngredientList[indexPath.row] as AvailableIngredients
        
        cell.textLabel?.text =  data.name
        
        var quantity =  data.quantity
        
        var unit =  data.unit

        cell.detailTextLabel?.text = "\(quantity) \(unit)"
        

        
        return cell
    }
    
    // Override to support editing the table view.
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if let tv = tableView as UITableView?{
      
                recipeIngredientList.removeAtIndex(indexPath.row)
                tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
        
        var error: NSError? = nil
        if !context.save(&error)
        {
            abort()
        }
        
        
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "recipeMethodPage"
        {
            let IVC: AddMethodToRecipeController = segue.destinationViewController as! AddMethodToRecipeController
            
            IVC.recipeTitle =   recipeTitle
            IVC.photoPath = photoPath
            IVC.recipeIngredientList = recipeIngredientList
            
            IVC.recipeDuration = recipeDuration
            IVC.recipeServing = recipeServing
        }
        
    }

}

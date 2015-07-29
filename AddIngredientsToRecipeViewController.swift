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

    var recipeTitle: String = ""
    
    var photoPath: String = ""
    
    var recipeDuration: String = ""
    
    var recipeServing: String = ""
    
    var recipeIngredientList: [AvailableIngredients] = [AvailableIngredients]()
    
    @IBOutlet weak var quantityStepper: UIStepper!
    
    @IBOutlet weak var ingredientAddedTable: UITableView!
    var list: [String] = []//["1","2","03"]
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
        // Dispose of any resources that can be recreated.
    }
    
    //to hide keyboard on screen
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
    }
    
 
    @IBAction func onValueChangeQuantityStepper(sender: AnyObject) {
        ingreditentQuantity.text = Int(quantityStepper.value).description
    }
    
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
        ingreditentQuantity.text = ""
        ingredientUnit.text = ""
        
    }
    
    func textFieldShouldReturn(button: UIButton) -> Bool {
        
     //   textField.resignFirstResponder()
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
//        var cell = tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath) as! UITableViewCell
//        
//        
//        let row = indexPath.row
//        cell.textLabel?.text = list[row]
//        

        let cell = tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath) as! UITableViewCell
        
        
        var data: AvailableIngredients = recipeIngredientList[indexPath.row] as AvailableIngredients
        
        
        
        cell.textLabel?.text =  data.name  //(data.valueForKey("name") as! String)
        
        var quantity =  data.quantity  //data.valueForKey("quantity") as! String
        
        var unit =  data.unit
        //data.valueForKey("unit") as! String
        
        cell.detailTextLabel?.text = "\(quantity) \(unit)"
        

        
        return cell
    }
    
    // Override to support editing the table view.
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if let tv = tableView as UITableView?{
            //    context.deleteObject(recipeIngredientList[indexPath.row])
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "recipeMethodPage"
        {
            // var selectedItem: NSManagedObject = listRecipesDB[self.tableView.indexPathForSelectedRow()!.row] as! NSManagedObject
            let IVC: AddMethodToRecipeController = segue.destinationViewController as! AddMethodToRecipeController
            
            IVC.recipeTitle =   recipeTitle     //selectedItem.valueForKey("title") as! String
            IVC.photoPath = photoPath
            IVC.recipeIngredientList = recipeIngredientList
            
            IVC.recipeDuration = recipeDuration
            IVC.recipeServing = recipeServing
            //            IVC.numberOfServings = selectedItem.valueForKey("servings") as! String
            //            IVC.recipeDirection = selectedItem.valueForKey("method") as! String
            //
            //            IVC.recipeDuration = selectedItem.valueForKey("duration") as! String
            //
            //
            //            IVC.recipeIngredients = selectedItem.valueForKey("ingredients") as! NSSet
            //            IVC.photo = selectedItem.valueForKey("photoPath") as! String
            //
            //            IVC.isFavouriteDB = selectedItem.valueForKey("isFavourite") as! String
            //            IVC.existingItem =  selectedItem
        }
        
    }

}

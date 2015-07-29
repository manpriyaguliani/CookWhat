//
//  AvailableIngredientsTableViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 11/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class AvailableIngredientsTableViewController: UITableViewController {

    var listIngredientsDB: Array<AnyObject> = []
    
    var ingredientList: [AvailableIngredients] = [AvailableIngredients]()
    override func viewDidLoad() {
        super.viewDidLoad()

         self.clearsSelectionOnViewWillAppear = false
    
        tableView.reloadData()
        
        
    }

    func dummyData(){
        var avIng: AvailableIngredients = AvailableIngredients();

        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "AvailIngredients")
        listIngredientsDB =   context.executeFetchRequest(freq, error: nil)!
        println(listIngredientsDB.count)
        tableView.reloadData()
        for item in listIngredientsDB
        {
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(didAppear: Bool) {
        super.viewDidAppear(didAppear)
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "AvailIngredients")
        listIngredientsDB =   context.executeFetchRequest(freq, error: nil)!
        println(listIngredientsDB.count)
        
        //listIngredientsDB = listIngredientsDB.sorted( ($0 as! AvailableIngredients).name < ($1 as! AvailableIngredients).name)
        
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
      
        return listIngredientsDB.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       // dummyData()
        
        let cell = tableView.dequeueReusableCellWithIdentifier("availableIngredientCell", forIndexPath: indexPath) as! UITableViewCell

        
        var data: NSManagedObject = listIngredientsDB[indexPath.row] as! NSManagedObject
        
      
        
        cell.textLabel?.text = (data.valueForKey("name") as! String)
        
        var quantity = data.valueForKey("quantity") as! String
        
        var unit = data.valueForKey("unit") as! String
        
        cell.detailTextLabel?.text = "\(quantity) \(unit)"
        
        
        
        
        // Configure the cell...
       // let row = indexPath.row
        
        
        //cell.detailTextLabel?.text = quantity + ingredientList[row].unit
        
        //cell.textLabel?.text = ingredientList[row].title

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
//      //      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            let _indexPath = tableView.indexPathForSelectedRow();
//            
//            let currentCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!;
//            
//            listIngredientsDB.removeAtIndex(indexPath.row)
//            
//            
//            tableView.reloadData()
//
//            
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//        
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if let tv = tableView as UITableView?{
                context.deleteObject(listIngredientsDB[indexPath.row] as! NSManagedObject)
                listIngredientsDB.removeAtIndex(indexPath.row)
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
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "existingIngredient"
        {
            var selectedItem: NSManagedObject = listIngredientsDB[self.tableView.indexPathForSelectedRow()!.row] as! NSManagedObject
            let IVC: AddIngredientsViewController = segue.destinationViewController as! AddIngredientsViewController
            
            IVC.name = selectedItem.valueForKey("name") as! String
            IVC.quantity = selectedItem.valueForKey("quantity") as! String
            IVC.unit = selectedItem.valueForKey("unit") as! String
            
            IVC.existingItem =  selectedItem
        }
        
    }
    
}

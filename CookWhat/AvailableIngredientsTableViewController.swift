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

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       //  self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        
        
       
      //  dummyData()
        tableView.reloadData()
        
        
    }

    func dummyData(){
        var avIng: AvailableIngredients = AvailableIngredients();
//        avIng.title = "Egg"
//        avIng.quantity = "10"
//        ingredientList.append(avIng)
//        avIng = AvailableIngredients();
//        avIng.title = "Potato"
//        avIng.quantity = "1"
//        avIng.unit = "kg"
//        ingredientList.append(avIng)
//        avIng = AvailableIngredients();
//        avIng.title = "Rice"
//        avIng.quantity = "4"
//        avIng.unit = "kg"
//        ingredientList.append(avIng)
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "AvailIngredients")
        listIngredientsDB =   context.executeFetchRequest(freq, error: nil)!
        println(listIngredientsDB.count)
        tableView.reloadData()
        for item in listIngredientsDB
        {
//            avIng.title = item.name
//            avIng.quantity = item.quantity
//            avIng.unit = item.unit
//            ingredientList.append(avIng)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(didAppear: Bool) {
        super.viewDidAppear(didAppear)
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "AvailIngredients")
        listIngredientsDB =   context.executeFetchRequest(freq, error: nil)!
        println(listIngredientsDB.count)
        
        
        
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

}

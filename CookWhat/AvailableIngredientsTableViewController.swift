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
        
        let sorter = NSSortDescriptor(key: "name", ascending : true)
        freq.sortDescriptors = [sorter]
        
        listIngredientsDB =   context.executeFetchRequest(freq, error: nil)!
       
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listIngredientsDB.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("availableIngredientCell", forIndexPath: indexPath) as! UITableViewCell

        
        var data: NSManagedObject = listIngredientsDB[indexPath.row] as! NSManagedObject
        
      
        
        cell.textLabel?.text = (data.valueForKey("name") as! String)
        
        var quantity = data.valueForKey("quantity") as! String
        
        var unit = data.valueForKey("unit") as! String
        
        cell.detailTextLabel?.text = "\(quantity) \(unit)"
          return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

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

//
//  SuggestedRecipesTableViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 02/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class SuggestedRecipesTableViewController: UITableViewController, UITableViewDataSource {

    //Filters
    var duration: String = ""
    var servings: String = ""
    var levelOfDifficulty : String = ""
    
    
    var recipeListDB: Array<AnyObject> = []
    var myIngrList: Array<AnyObject> = []
    var _fetchedResultsController: NSFetchedResultsController!
    
    
    var recipeList: [RecipeToSuggest] = [RecipeToSuggest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        recipeList.removeAll(keepCapacity: true)
        loadDataFromDB()
        filterDBList()
        tableView.reloadData()
    }
    
    override func viewDidAppear(didAppear: Bool) {
        super.viewDidAppear(didAppear)
        recipeList.removeAll(keepCapacity: true)

        loadDataFromDB()
        filterDBList()
        tableView.reloadData()
        
    }

    func dummyData(){
        var sugRec: RecipeToSuggest = RecipeToSuggest();
       
        sugRec.title = "Potato wedges"
        sugRec.time = "15"
        recipeList.append(sugRec)
        sugRec = RecipeToSuggest();
        sugRec.title = "Boiled Rice"
        sugRec.time = "20"
        recipeList.append(sugRec)
        sugRec = RecipeToSuggest();
        sugRec.title = "Biryani"
        sugRec.time = "60"
        recipeList.append(sugRec)

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromDB(){
    
    
    let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let context:NSManagedObjectContext = appDel.managedObjectContext!
    let freq = NSFetchRequest(entityName: "Recipes")
    let fetchIngr = NSFetchRequest(entityName: "Ingredients")
    recipeListDB =  context.executeFetchRequest(freq, error: nil)!
    myIngrList =   context.executeFetchRequest(fetchIngr, error: nil)!
    

    }
    
    func filterDBList(){
      
        var recipeListObj : RecipeToSuggest = RecipeToSuggest()
        
        var i : Int = 0
        while i < recipeListDB.count{
            var recipeDBObj: NSManagedObject = recipeListDB[i] as! NSManagedObject
 
            if (recipeDBObj.valueForKey("duration") as! String).toInt() <= duration.toInt() {
                recipeListObj.title = recipeDBObj.valueForKey("title") as! String
        
                recipeListObj.time = recipeDBObj.valueForKey("duration") as! String
            
                recipeList.append(recipeListObj)
            }
          i++
        }
        
        recipeList = recipeList.sorted { $0.time < $1.time }
    }
    
   

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return recipeList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("suggestedRecipeCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        let row = indexPath.row
       
        
        cell.detailTextLabel?.text = recipeList[row].title
        
        cell.textLabel?.text = recipeList[row].time + "mins"

      

        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
           // tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let _indexPath = tableView.indexPathForSelectedRow();
            
            let currentCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!;
            
            recipeList.removeAtIndex(indexPath.row)
            
            
            tableView.reloadData()

        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
//        let vc: RecipeDetailsViewController = segue.destinationViewController as! RecipeDetailsViewController
//        vc.recipeTitle = "My Recipe"
//        vc.numberOfServings = "1"
//        vc.recipeDirection = "recipe direction"
        
        if segue.identifier == "suggestedRecipeDetail"
        {
//            var selectedItem: NSManagedObject = myList[self.tableView.indexPathForSelectedRow()!.row] as! NSManagedObject
//            let IVC: RecipeDetailsViewController = segue.destinationViewController as! RecipeDetailsViewController
//            
//            IVC.recipeTitle = selectedItem.valueForKey("title") as! String
//            IVC.numberOfServings = selectedItem.valueForKey("servings") as! String
//            IVC.recipeDirection = selectedItem.valueForKey("method") as! String
//            
//            IVC.recipeDuration = selectedItem.valueForKey("duration") as! String
//            
//            // IVC.info = selectedItem.valueForKey("info") as! String
//            //   IVC.existingItem =  selectedItem
//            
//            IVC.recipeIngredients = selectedItem.valueForKey("ingredients") as! NSSet
        
        }
    }
    
    

}

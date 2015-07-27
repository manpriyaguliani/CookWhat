//
//  SuggestedRecipesTableViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 02/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//












//SADLY ENOUGH

//Limitations: You cannot necessarily translate “arbitrary” SQL queries into predicates or fetch requests. There is no way, for example, to convert a SQL statement such as
//SELECT t1.name, V1, V2
//FROM table1 t1 JOIN (SELECT t2.name AS V1, count(*) AS V2
//FROM table2 t2 GROUP BY t2.name as V) on t1.name = V.V1
//into a fetch request. You must fetch the objects of interest, then either perform a calculation directly using the results, or use an array operator.




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
    var recipeIngredientList: [AvailableIngredients] = [AvailableIngredients]()
   
    var listIngredientsDB: Array<AnyObject> = []
    
    var recipeList: [RecipeToSuggest] = [RecipeToSuggest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        recipeList.removeAll(keepCapacity: true)
        loadDataFromDB()
        loadAvailableIngredientsList()
        filterDBList()
        tableView.reloadData()
    }
    
    override func viewDidAppear(didAppear: Bool) {
        super.viewDidAppear(didAppear)

        
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
    
    func loadAvailableIngredientsList(){
    
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "AvailIngredients")
        listIngredientsDB =   context.executeFetchRequest(freq, error: nil)!
        
    }
    
    func loadRecipeIngredients(dbRecipeIngredients : NSSet){
        var avIng: AvailableIngredients = AvailableIngredients();
        
        let listOfIngredients = dbRecipeIngredients.allObjects as! [Ingredients]
        recipeIngredientList.removeAll(keepCapacity: true)
        for item in listOfIngredients as NSArray
        {
            avIng.name = item.valueForKey("name") as! String
            avIng.quantity = item.valueForKey("quantity") as! String
            avIng.unit = item.valueForKey("unit") as! String
            recipeIngredientList.append(avIng)
            avIng = AvailableIngredients();
            
        }
    }
    
    func areAllIngredientsAvailable() -> Bool
    {
        // compare recipeIngredientList and listIngredientsDB
        var allIngredientsAvailable : Int = 0
        var i : Int = 0
     
        while i < recipeIngredientList.count {
              println(recipeIngredientList[i].name + recipeIngredientList[i].quantity)
            for ing in listIngredientsDB {
                var item = ing as! NSManagedObject
              println(item.valueForKey("name") as! String)
                println(item.valueForKey("quantity") as! String)
                if recipeIngredientList[i].name == item.valueForKey("name") as! String {
                    if  recipeIngredientList[i].quantity.toInt() > (item.valueForKey("quantity") as! String).toInt() {
                        return false
                    }
                    else{
                     allIngredientsAvailable++
                        break
                    }
                }
               
                
            }
            i++
        }
        var count = recipeIngredientList.count
        if allIngredientsAvailable == recipeIngredientList.count {
            return true
            
           
        }
        else {
            return false
        }
    }
    
    
       
    
    
    func filterDBList(){
      
        var recipeListObj : RecipeToSuggest = RecipeToSuggest()
        
        var i : Int = 0
        while i < recipeListDB.count{
            var recipeDBObj: NSManagedObject = recipeListDB[i] as! NSManagedObject
 
            var dbRecipeDuration: Int = (recipeDBObj.valueForKey("duration") as! String).toInt()!
            var dbRecipeIngredients = recipeDBObj.valueForKey("ingredients") as! NSSet
            if  dbRecipeDuration <= duration.toInt() {
                println(recipeDBObj.valueForKey("title") as! String)
                loadRecipeIngredients(dbRecipeIngredients) //Loaded in Recipe Ingredient List
                loadAvailableIngredientsList()
                
                //if match then..
                if areAllIngredientsAvailable() {
                    recipeListObj = RecipeToSuggest()
                    recipeListObj.title = recipeDBObj.valueForKey("title") as! String
        
                    recipeListObj.time = dbRecipeDuration
            
                    recipeList.append(recipeListObj)
                }
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
        
        cell.textLabel?.text = recipeList[row].time.description + "mins"
        
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

    
   
    func getDBIndexforRecipe(index : Int) -> Int {
        
        var i: Int = 0
        
        while i < recipeListDB.count{
            var selectedItem: NSManagedObject = recipeListDB[i] as! NSManagedObject
            var recipeTitle = selectedItem.valueForKey("title") as! String
            if recipeTitle == recipeList[index].title
            {
                return i
            }
            i++
        }
        return -1
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        
        if segue.identifier == "suggestedRecipeDetail"
        {
            var index: Int = getDBIndexforRecipe(self.tableView.indexPathForSelectedRow()!.row)
            if index != -1{
                var selectedItem: NSManagedObject = recipeListDB[index] as! NSManagedObject
                let IVC: RecipeDetailsViewController = segue.destinationViewController as! RecipeDetailsViewController
                
                IVC.recipeTitle = selectedItem.valueForKey("title") as! String
                IVC.numberOfServings = selectedItem.valueForKey("servings") as! String
                IVC.recipeDirection = selectedItem.valueForKey("method") as! String
                IVC.recipeDuration = selectedItem.valueForKey("duration") as! String
                IVC.recipeIngredients = selectedItem.valueForKey("ingredients") as! NSSet
                IVC.photo = selectedItem.valueForKey("photoPath") as! String
                IVC.isFavouriteDB = selectedItem.valueForKey("isFavourite") as! String

                IVC.existingItem =  selectedItem
            }

        
        }
    }
    
    

}

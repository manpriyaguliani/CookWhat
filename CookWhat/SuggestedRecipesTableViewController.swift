//
//  SuggestedRecipesTableViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 02/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//



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

        self.clearsSelectionOnViewWillAppear = false

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
       
    }
    
    func loadDataFromDB(){
    
    //load list of recipes and their corresponding ingredients
    let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let context:NSManagedObjectContext = appDel.managedObjectContext!
    let freq = NSFetchRequest(entityName: "Recipes")
    let fetchIngr = NSFetchRequest(entityName: "Ingredients")
    recipeListDB =  context.executeFetchRequest(freq, error: nil)!
    myIngrList =   context.executeFetchRequest(fetchIngr, error: nil)!
  
    }
    
    func loadAvailableIngredientsList(){
    
        // load available ingredients from db
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "AvailIngredients")
        listIngredientsDB =   context.executeFetchRequest(freq, error: nil)!
        
    }
    
    //load corresponding ingredients of recipes
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
            for ing in listIngredientsDB {
                var item = ing as! NSManagedObject
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
                loadRecipeIngredients(dbRecipeIngredients) //Loaded in Recipe Ingredient List
                loadAvailableIngredientsList()
                
                
                if areAllIngredientsAvailable() {
                    recipeListObj = RecipeToSuggest()
                    recipeListObj.title = recipeDBObj.valueForKey("title") as! String
        
                    recipeListObj.time = dbRecipeDuration
                    recipeListObj.photo = recipeDBObj.valueForKey("photoPath") as! String
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
        
        cell.textLabel?.text = recipeList[row].time.description + "min"
        
        
        var photo = recipeList[row].photo
        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDir: NSString = paths.objectAtIndex(0) as! String
        let path: NSString = documentsDir.stringByAppendingString(photo)
        
        //load image depending on preloaded data and uploaded image
        if photo.rangeOfString("file:///") != nil {
            photo = photo.substringFromIndex(advance(photo.startIndex, 8))
            cell.imageView?.image = UIImage(named: photo)
        }
        else{
            cell.imageView?.image = UIImage(contentsOfFile: path as String)!
            photo = path as String
        }
        

        let xOffset: CGFloat = 10
        let contentViewFrame = cell.contentView.frame
        let imageView = UIImageView()
        imageView.image = UIImage(named: photo)
        imageView.frame = CGRectMake(xOffset, CGFloat(5), CGFloat(35), CGFloat(35))
        cell.contentView.addSubview(imageView)
      
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {

        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source

            let _indexPath = tableView.indexPathForSelectedRow();
            
            let currentCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!;
            
            recipeList.removeAtIndex(indexPath.row)
            tableView.reloadData()

        } else if editingStyle == .Insert {

        }    
    }
    
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

    //send data of selected recipe forward to next controller
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

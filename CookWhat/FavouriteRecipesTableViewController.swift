//
//  FavouriteRecipesTableViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 11/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class FavouriteRecipesTableViewController: UITableViewController {

    var listRecipesDB: Array<AnyObject> = []
    var listRecipeIngredientsDB: Array<AnyObject> = []
    var _fetchedResultsController: NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

  }
    //***** fetching data from desired table
    override func viewDidAppear(animated: Bool) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
       
        //load list of recipes and their corresponding ingredients

        let freq = NSFetchRequest(entityName: "Recipes")
        
        //sort
        let sorter = NSSortDescriptor(key: "title", ascending : true)
        freq.sortDescriptors = [sorter]
        
        let fetchIngr = NSFetchRequest(entityName: "Ingredients")
        
        let sorter2 = NSSortDescriptor(key: "name", ascending : true)
        fetchIngr.sortDescriptors = [sorter2]
        
        var predicate: NSPredicate = NSPredicate(format: "isFavourite == %@", "true")
        
        freq.predicate = predicate

        listRecipesDB =   context.executeFetchRequest(freq, error: nil)!
        listRecipeIngredientsDB =   context.executeFetchRequest(fetchIngr, error: nil)!
        
        tableView.reloadData()
    
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return listRecipesDB.count
    }

    //***** loading code into table cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


        // Configure the cell...
        
        let CellId: NSString = "Cell"
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellId as String) as! UITableViewCell
        
        var data: NSManagedObject = listRecipesDB[indexPath.row] as! NSManagedObject
        
        var dataIngr: NSManagedObject = listRecipeIngredientsDB[indexPath.row] as! NSManagedObject
        
        
            var serv = data.valueForKey("servings") as! String
           
            var ingr = dataIngr.valueForKey("name") as! String
        
            cell.detailTextLabel?.text = (data.valueForKey("title") as! String)
        
        cell.textLabel?.text = data.valueForKey("duration") as! String + "min"
  
        //image values depending on preloaded data or new recipe
        var photo = data.valueForKey("photoPath") as! String
    
        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDir: NSString = paths.objectAtIndex(0) as! String
        let path: NSString = documentsDir.stringByAppendingString(photo)

        
        if photo.rangeOfString("file:///") != nil {
            photo = photo.substringFromIndex(advance(photo.startIndex, 8))
            cell.imageView?.image = UIImage(named: photo)
        }
        else if photo.rangeOfString("/no-recipe-image.jpg") != nil
        {
            cell.imageView?.image = UIImage(named: "no-recipe-image.jpg")!
        }
        else{
            cell.imageView?.image = UIImage(contentsOfFile: path as String)!
            photo = path as String
        }

        //set image view dynamically
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
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if let tv = tableView as UITableView?{
                context.deleteObject(listRecipesDB[indexPath.row] as! NSManagedObject)
                listRecipesDB.removeAtIndex(indexPath.row)
                tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
        
        var error: NSError? = nil
        if !context.save(&error)
        {
            abort()
        }
   
    }

    //forward data to next controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if segue.identifier == "recipeDetail"
        {
            var selectedItem: NSManagedObject = listRecipesDB[self.tableView.indexPathForSelectedRow()!.row] as! NSManagedObject
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

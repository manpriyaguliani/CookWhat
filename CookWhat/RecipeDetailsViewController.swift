//
//  RecipeDetailsViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 02/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class RecipeDetailsViewController: UIViewController,UITableViewDataSource {

    @IBOutlet weak var favouritesButton: UIButton!
    
    @IBOutlet weak var lblRecipeTitle: UILabel!
    
    @IBOutlet weak var lblNumberOfServings: UILabel!
    
    @IBOutlet weak var txtViewDirections: UITextView!
    @IBOutlet weak var tblViewIngredients: UITableView!
    @IBOutlet weak var durationText: UILabel!
    
    var ingredientList: [AvailableIngredients] = [AvailableIngredients]()
    var recipeTitle: String = ""
    var numberOfServings: String = ""
    var recipeDirection: String = ""
    var recipeIngredients: NSSet = []
    var recipeDuration: String = ""
    var photo: String = ""
    var isFavourite: Bool = false
    var isFavouriteDB: String = ""
    
    var existingItem: NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeControls()
         dummyData();
        tblViewIngredients.dataSource = self;
     //    tblViewIngredients.reloadData()
    }
    
    override func viewDidAppear(didAppear: Bool) {
        super.viewDidAppear(didAppear)
        println(isFavouriteDB)
        
        
        if isFavouriteDB == "true"
        {
            favouritesButton.setBackgroundImage(UIImage(named: "favStarFilled")!, forState: UIControlState.Normal)           // favouritesButton.imageView?.image = UIImage(named: "favStarUnFilled")!
        }
        else
        {
            favouritesButton.setBackgroundImage(UIImage(named: "favStarUnfilled")!, forState: UIControlState.Normal)
            
           // favouritesButton.imageView?.image = UIImage(named: "favStarFilled")!
        }

        
        tblViewIngredients.reloadData()
    }

    func dummyData(){
        var avIng: AvailableIngredients = AvailableIngredients();
        
        let listOfIngredients = recipeIngredients.allObjects as! [Ingredients]
        
        for item in listOfIngredients as NSArray
        {
            avIng.name = item.valueForKey("name") as! String
            avIng.quantity = item.valueForKey("quantity") as! String
            avIng.unit = item.valueForKey("unit") as! String
            ingredientList.append(avIng)
            avIng = AvailableIngredients();
            println(item.valueForKey("name"))
            println(item.valueForKey("quantity"))
            println(item.valueForKey("unit"))

            
        }
        

    }
    func initializeControls(){
     lblRecipeTitle.text = recipeTitle
   //  lblNumberOfServings.text = numberOfServings
     txtViewDirections.text = recipeDirection
        
        var mins: String = "Minutes"
     durationText.text = recipeDuration +  "\(mins)"
        
        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDir: NSString = paths.objectAtIndex(0) as! String
        let path: NSString = documentsDir.stringByAppendingString(photo)
        
//        var imageView = UIImageView(frame: CGRectMake(200, 70, 100, 100));
         var imageView = UIImageView(frame: CGRectMake(0, 0, 500, 500));
           var image : UIImage
        
        println(photo)
        
        if photo.rangeOfString("file:///") != nil {
            photo = photo.substringFromIndex(advance(photo.startIndex, 8))
            image = UIImage(named: photo)!
        }
        else{
            image = UIImage(contentsOfFile: path as String)!
        }
        imageView.image = image;
        imageView.alpha = 0.3
        
        self.view.addSubview(imageView);
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // Return the number of sections.
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return ingredientList.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ingredientsCell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        let row = indexPath.row
        
        
        cell.textLabel?.text = ingredientList[row].quantity + " " + ingredientList[row].unit
        
        cell.detailTextLabel?.text = ingredientList[row].name
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
     func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    //MG: Update DB  - done
    @IBAction func onClickFavStar(sender: AnyObject) {
        
        //Reference to AppDelegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        //Reference to Context
        
        let contxt:NSManagedObjectContext = appDel.managedObjectContext!
        
        let en = NSEntityDescription.entityForName("Recipes" , inManagedObjectContext: contxt)
        
        
        if isFavourite {
            isFavourite = false
            favouritesButton.setBackgroundImage(UIImage(named: "favStarUnfilled")!, forState: UIControlState.Normal)
            
            
            if (existingItem != nil){
                existingItem.setValue("false", forKey: "isFavourite")
              
            }
          
            
        }
        else
        {
            isFavourite = true
            favouritesButton.setBackgroundImage(UIImage(named: "favStarFilled")!, forState: UIControlState.Normal)
            
            
            if (existingItem != nil){
                existingItem.setValue("true", forKey: "isFavourite")
                

        }
        
        //save context
        contxt.save(nil)
        
    }
    
    }
    
    // Override to support editing the table view.
//     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
//            //      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            let _indexPath = tableView.indexPathForSelectedRow();
//            
//            let currentCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!;
//            
//            ingredientList.removeAtIndex(indexPath.row)
//            
//            
//            tableView.reloadData()
//            
//            
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

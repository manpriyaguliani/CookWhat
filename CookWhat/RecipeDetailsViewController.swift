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
    
    @IBOutlet weak var useRecipeBtn: UIButton!
    var listIngredientsDB: Array<AnyObject> = []
    
    var recipeIngredientList: [AvailableIngredients] = [AvailableIngredients]()
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
        recipeIngredientList.removeAll(keepCapacity: true)
        for item in listOfIngredients as NSArray
        {
            avIng.name = item.valueForKey("name") as! String
            avIng.quantity = item.valueForKey("quantity") as! String
            avIng.unit = item.valueForKey("unit") as! String
            recipeIngredientList.append(avIng)
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
     
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "AvailIngredients")
        listIngredientsDB =   context.executeFetchRequest(freq, error: nil)!

        
        
        
        
        
        
        
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
            else if photo.rangeOfString("/no-recipe-image.jpg") != nil
        {
            image = UIImage(named: "no-recipe-image.jpg")!
        }
        else{
            image = UIImage(contentsOfFile: path as String)!
        }
        imageView.image = image;
        imageView.alpha = 0.3
        
        self.view.addSubview(imageView);
        
        
    }
    
    @IBAction func updateIngredients(sender: AnyObject) {
        var i : Int = 0
        var allIngredientsAvailable : Int = 0
 
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "AvailIngredients")
        listIngredientsDB =   context.executeFetchRequest(freq, error: nil)!

        useRecipeBtn.enabled = false


        while i < recipeIngredientList.count {
            println(recipeIngredientList[i].name + recipeIngredientList[i].quantity)
            for ing in listIngredientsDB {
                var item: NSManagedObject! = ing as! NSManagedObject
            //    println(item.valueForKey("name") as! String)
            //    println(item.valueForKey("quantity") as! String)
                
                if(item.valueForKey("name") != nil)
                {
                    println(item.valueForKey("name"))
                if recipeIngredientList[i].name == item.valueForKey("name") as! String
                {
                    //                    var a: Double = Double((item.valueForKey("quantity") as! String).toInt()!)
                    //                    //var b: Double = Double(recipeIngredientList[i].quantity.toInt()!)
                    //                    var str = "0.5" //recipeIngredientList[i].quantity
                    //                    var b: Double! = Double(str.toInt()!)
                    //
                    //                        println("recipeIngredientList[i].quantity")
                    //                            println(recipeIngredientList[i].quantity)
                    //                    var c: Double = a - b
                    
                    //NEED SUBTRACTION LOGIC HERE
                    //UPDATION WORKS FINE
                    var remainingQuantity: Int
                    
                    var recipeQ = recipeIngredientList[i].quantity.toInt()!
                    
                    remainingQuantity = (item.valueForKey("Quantity") as! String).toInt()! - recipeQ
                    
                    ing.setValue(remainingQuantity.description, forKey: "quantity")
                    
                    
                  
                    
                }
                
                if((item.valueForKey("quantity")as! String).toInt() == 0)
                {
                    //Delete if ZERO
                    context.deleteObject(item as NSManagedObject)
                    context.save(nil)
                }
                
                context.save(nil)
                }
            }
            i++
            
        }
        
        let alert = UIAlertView()
        alert.title = "Recipe Used"
        alert.message = "Available Ingredients list has been updated."
        alert.addButtonWithTitle("Ok")
        alert.show()
        
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
        return recipeIngredientList.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ingredientsCell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        let row = indexPath.row
        
        
        cell.textLabel?.text = recipeIngredientList[row].quantity + " " + recipeIngredientList[row].unit
        
        cell.detailTextLabel?.text = recipeIngredientList[row].name
        
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
//            recipeIngredientList.removeAtIndex(indexPath.row)
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

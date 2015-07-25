//
//  RecipeDetailsViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 02/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController,UITableViewDataSource {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeControls()
         dummyData();
        tblViewIngredients.dataSource = self;
     //    tblViewIngredients.reloadData()
    }

    func dummyData(){
        var avIng: AvailableIngredients = AvailableIngredients();
        
        let listOfIngredients = recipeIngredients.allObjects as! [Ingredients]
        
        for item in listOfIngredients as NSArray
        {
            avIng.title = item.valueForKey("name") as! String
            avIng.quantity = item.valueForKey("quantity") as! String
            avIng.unit = item.valueForKey("unit") as! String
            ingredientList.append(avIng)
            avIng = AvailableIngredients();
            println(item.valueForKey("name"))
            println(item.valueForKey("quantity"))
            println(item.valueForKey("unit"))

            
        }
        
//        
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
//        avIng = AvailableIngredients();
//        avIng.title = "Apple"
//        avIng.quantity = "4"
//        avIng.unit = "kg"
//        ingredientList.append(avIng)
//        avIng = AvailableIngredients();
//        avIng.title = "Orange"
//        avIng.quantity = "4"
//        avIng.unit = "kg"
//        ingredientList.append(avIng)
//        avIng = AvailableIngredients();
//        avIng.title = "Flour"
//        avIng.quantity = "4"
//        avIng.unit = "kg"
//        ingredientList.append(avIng)
    }
    func initializeControls(){
     lblRecipeTitle.text = recipeTitle
     lblNumberOfServings.text = numberOfServings
     txtViewDirections.text = recipeDirection
        
        var mins: String = "Minutes"
     durationText.text = recipeDuration +  "\(mins)"
        
        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDir: NSString = paths.objectAtIndex(0) as! String
        let path: NSString = documentsDir.stringByAppendingString(photo)
        
        var imageView = UIImageView(frame: CGRectMake(200, 70, 100, 100));
           var image : UIImage
        
        if photo.rangeOfString("file:///") != nil {
            photo = photo.substringFromIndex(advance(photo.startIndex, 8))
            image = UIImage(named: photo)!
        }
        else{
            image = UIImage(contentsOfFile: path as String)!
        }
        imageView.image = image;
        
        self.view.addSubview(imageView);
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(didAppear: Bool) {
        super.viewDidAppear(didAppear)
        tblViewIngredients.reloadData()
        
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
        
        
        cell.detailTextLabel?.text = ingredientList[row].quantity + ingredientList[row].unit
        
        cell.textLabel?.text = ingredientList[row].title
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
     func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
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

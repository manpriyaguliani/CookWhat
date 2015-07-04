//
//  SuggestedRecipesTableViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 02/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit

class SuggestedRecipesTableViewController: UITableViewController, UITableViewDataSource {

    var recipeList: [RecipeToSuggest] = [RecipeToSuggest]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        dummyData();
        
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
    
    override func viewDidAppear(didAppear: Bool) {
        super.viewDidAppear(didAppear)
        tableView.reloadData()
        
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
        
        cell.textLabel?.text = recipeList[row].time + "min"


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
        
        let vc: RecipeDetailsViewController = segue.destinationViewController as! RecipeDetailsViewController
        vc.recipeTitle = "My Recipe"
        vc.numberOfServings = "1"
        vc.recipeDirection = "recipe direction"
        
    }
    

}

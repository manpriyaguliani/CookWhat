//
//  AddIngredientsToRecipeViewController.swift
//  CookWhat
//
//  Created by MCP 2015 on 24/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit

class AddIngredientsToRecipeViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var ingredientAddedTable: UITableView!
    var list: [String] = []//["1","2","03"]
    @IBOutlet weak var ingredientName: UITextField!
    
    @IBOutlet weak var ingreditentQuantity: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientAddedTable.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //to hide keyboard on screen
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
    }
    @IBAction func onAddBtnClick(sender: AnyObject) {
        
        list.append(ingredientName.text)
        ingredientAddedTable.reloadData()
    }
    //Data Source function Override
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath) as! UITableViewCell
        
        
        let row = indexPath.row
        cell.textLabel?.text = list[row]
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

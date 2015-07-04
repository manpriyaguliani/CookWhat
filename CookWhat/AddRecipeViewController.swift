//
//  AddRecipeViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 11/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class AddRecipeViewController: UIViewController {

    @IBOutlet weak var recipeTitleText: UITextField!
    @IBOutlet weak var recipeServingText: UITextField!
    
    
   // var recipeTitle: String = ""
   // var recipeServing: String = "1"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //***** saving recipe
    @IBAction func saveTapped(sender: AnyObject) {
        
        //Reference to AppDelegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        //Reference to Context
        let contxt:NSManagedObjectContext = appDel.managedObjectContext!
        
        let en = NSEntityDescription.entityForName("Recipes" , inManagedObjectContext: contxt)
        
        
        //Create instance of data model
            var newItem = Model(entity:en!, insertIntoManagedObjectContext: contxt)
            
            
            //map properties
            
            newItem.title = recipeTitleText.text
            newItem.servings = recipeServingText.text
        
            println(newItem)
        
        
        //save context
        contxt.save(nil)
        
        
        //navigate back to root Vc
        self.navigationController?.popToRootViewControllerAnimated(true)

        
    }

    @IBAction func cancelTapped(sender: AnyObject) {
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

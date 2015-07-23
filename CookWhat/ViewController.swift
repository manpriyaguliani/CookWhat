//
//  ViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 10/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

// used for viewing recipes
class ViewController: UIViewController {

    var recipeTitle: String = ""
    var recipeServings: String = ""
    //var info: String = ""
    
    //test test
    //test test

    
    @IBOutlet weak var lblServings: UILabel!
    @IBOutlet weak var stpServings: UIStepper!
    
    @IBOutlet weak var segmentExpertise: UISegmentedControl!
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var servingsText: UITextField!
    
   // var existingItem: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   /*     if (existingItem != nil){
            titleText.text = recipeTitle
            servingsText.text = recipeServings
            //textFieldQuantity.text = quantity
        }*/
        
        if !isDataLoaded {
        //loadData()
            isDataLoaded = true
        }
        
        
        if(lblServings != nil){
            lblServings.text = "1"
        }
        if(stpServings != nil){
            stpServings.minimumValue = 1
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onValueChange(sender: UIStepper, forEvent event: UIEvent) {
        lblServings.text = Int(stpServings.value).description
    }
    


}


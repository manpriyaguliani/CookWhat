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
    var time: String = ""
    var servings: String = ""
    
    @IBOutlet weak var lblServings: UILabel!
    @IBOutlet weak var stpServings: UIStepper!
    
    
    @IBOutlet weak var availableTimePicker: UIDatePicker!
    @IBOutlet weak var segmentExpertise: UISegmentedControl!
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var servingsText: UITextField!
    
   // var existingItem: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if(lblServings != nil){
            lblServings.text = "1"
            servings = lblServings.text!
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
        servings = lblServings.text!

    }
    
    @IBAction func onValueChangeTimePicker(sender: UIDatePicker) {
       calculateTime()
    }
    
    func calculateTime(){
        var timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        if availableTimePicker != nil {
        time = timeFormatter.stringFromDate(availableTimePicker.date)
        
        
        var hours = time.subString(0,length: time.indexOf(":")).toInt()
        
        if time.indexOf("AM") != -1 && hours == 12 {
            hours = 0
        }
        
        var mins = time.subString(time.indexOf(":")+1,length: time.indexOf(" ") - (time.indexOf(":")+1)).toInt()
        mins = mins! + (hours! * 60)
        
        time = mins!.description
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "suggestedRecipeList"
        {
            
                    let vc: SuggestedRecipesTableViewController = segue.destinationViewController as! SuggestedRecipesTableViewController
            
                    calculateTime()
            
                    vc.duration = time
        }
    }



}


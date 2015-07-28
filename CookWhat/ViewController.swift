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
    
    @IBOutlet weak var leftArrow: UIImageView!
    
    @IBOutlet weak var availableTimePicker: UIDatePicker!
    @IBOutlet weak var segmentExpertise: UISegmentedControl!
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var servingsText: UITextField!
    
    
    
    
    
    let images = [
        UIImage(named: "thumb_arrow_1024.jpg")!,
        UIImage(named: "thumb_arrow_1024.jpg")!,
        UIImage(named: "thumb_arrow_1024.jpg"),
        ]
    var index = 0
    let animationDuration: NSTimeInterval = 0.45
    let switchingInterval: NSTimeInterval = 0.45

    
    
    
    
   // var existingItem: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.leftArrow1.alpha = 0
        
        leftArrow.image = images[index++]
        animateImageView()
        
        
        if(lblServings != nil){
            lblServings.text = "1"
            servings = lblServings.text!
        }
        if(stpServings != nil){
            stpServings.minimumValue = 1
        }
    
    }
    
    
    
    
    func animateImageView() {
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(self.switchingInterval * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                self.animateImageView()
            }
        }
        
        let transition = CATransition()
        //transition.type = kCATransitionFade
        
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight

        leftArrow.layer.addAnimation(transition, forKey: kCATransition)
        leftArrow.image = images[index]
        
        CATransaction.commit()
        
        index = index < images.count - 1 ? index + 1 : 0
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        UIView.animateWithDuration(1.0, animations: { () -> Void in
//             self.leftArrow1.alpha = 1.0 })
//
//        
//    }
    

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


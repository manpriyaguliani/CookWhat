//
//  AddRecipeViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 11/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class AddRecipeViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var recipeTitleText: UITextField!
    @IBOutlet weak var recipeServingText: UITextField!
    @IBOutlet weak var durationTimePicker: UIDatePicker!
    @IBOutlet weak var servingsSteppper: UIStepper!
    
   var time: String = ""
//    var recipeServing: String = ""
    
    var photoPath : String! = "/no-recipe-image.jpg"
    
   // let URL : NSString = NSURL(fileURLWithPath: "/no-recipe-image.jpg")!.absoluteString!
   // photoPath = URL as String
    
    
    @IBOutlet weak var photoPreview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeServingText.text = "1"
        servingsSteppper.minimumValue = 1
        
        
    }
    
    
    @IBAction func onValueChangeServingsStepper(sender: AnyObject) {
        
        recipeServingText.text = Int(servingsSteppper.value).description
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    //to hide keyboard on screen
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
    }   
    

//move text field up when keyboard shows up
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        var movementDuration:NSTimeInterval = 0.3
        var movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
    @IBAction func removePhoto(sender: AnyObject) {
        
        self.photoPath = "/no-recipe-image.jpg"
        self.photoPreview.image = UIImage(named: "no-recipe-image.jpg")
        
    }
    
    @IBAction func addPhoto(sender: AnyObject) {

        
        let imagePickerActionSheet = UIAlertController(title: "Click/Upload Photo",
            message: nil, preferredStyle: .ActionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                style: .Default) { (alert) -> Void in
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .Camera
                    self.presentViewController(imagePicker,
                        animated: true,
                        completion: nil)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        let libraryButton = UIAlertAction(title: "Choose Existing",
            style: .Default) { (alert) -> Void in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker,
                    animated: true,
                    completion: nil)
        }
        imagePickerActionSheet.addAction(libraryButton)
        
        
        let cancelButton = UIAlertAction(title: "Cancel",
            style: .Cancel) { (alert) -> Void in
            //    self.doShowMenu = true
        }
        imagePickerActionSheet.addAction(cancelButton)
        
        
        presentViewController(imagePickerActionSheet, animated: true,
            completion: nil)
        
    }
    
    @IBAction func onValueChangeTimePicker(sender: UIDatePicker) {
        calculateTime()
    }
    
    func calculateTime(){
        var timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        if durationTimePicker != nil {
            time = timeFormatter.stringFromDate(durationTimePicker.date)
            
            
            var hours = time.subString(0,length: time.indexOf(":")).toInt()
            
            if time.indexOf("AM") != -1 && hours == 12 {
                hours = 0
            }
            
            var mins = time.subString(time.indexOf(":")+1,length: time.indexOf(" ") - (time.indexOf(":")+1)).toInt()
            mins = mins! + (hours! * 60)
            
            time = mins!.description
        }
    }

    
    
    //UIImagePickerControllerDelegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let newImage = scalePhoto(image, size: CGSize(width: 100, height: 100))
        
        self.photoPreview.image = newImage
        
        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDir : String = paths.objectAtIndex(0) as! String
        
        var dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "dd-mm-yy-ss"
        
        let now : NSDate = NSDate(timeIntervalSinceNow: 0)
        let theDate: NSString = dateFormat.stringFromDate(now)
        
        
        //SET URL
        self.photoPath = NSString(format: "/%@.png", theDate) as String
        
        
        //Save FullScreenImage
        let PathForPhoto = documentsDir.stringByAppendingString(self.photoPath)
        
        let pngData :NSData = UIImagePNGRepresentation(newImage)
        pngData.writeToFile(PathForPhoto, atomically: true)
        
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func scalePhoto(image : UIImage, size: CGSize) -> UIImage
    {
        let scale : CGFloat = max(size.width/image.size.width, size.height/image.size.height)
        let width: CGFloat = image.size.width * scale
        let height: CGFloat = image.size.height * scale
        let imageRect: CGRect = CGRectMake((size.width-width)/2.0, (size.height-height)/2.0, width, height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.drawInRect(imageRect)
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    
    
    
    
    
    @IBAction func addIngredients(sender: AnyObject) {
        
       // var my:UITextField = UITextField(frame: CGRectMake(0, 0, 10, 10))
    }
    
    
//    @IBAction func cancelTapped(sender: AnyObject) {
//        
//        self.navigationController?.popToRootViewControllerAnimated(true)
//        
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "recipeIngredientPage"
        {
           // var selectedItem: NSManagedObject = listRecipesDB[self.tableView.indexPathForSelectedRow()!.row] as! NSManagedObject
            let IVC: AddIngredientsToRecipeViewController = segue.destinationViewController as! AddIngredientsToRecipeViewController
            
            IVC.recipeTitle =   recipeTitleText.text     //selectedItem.valueForKey("title") as! String
            IVC.photoPath = photoPath
            calculateTime()
            IVC.recipeDuration = time
            IVC.recipeServing = recipeServingText.text
            
 
        }

    }

}

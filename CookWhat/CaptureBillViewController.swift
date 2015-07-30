//
//  CaptureBillViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 11/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class CaptureBillViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate  {

    //Locals
    var activityIndicator:UIActivityIndicatorView!
    var doShowMenu: Bool = true
    
    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         textView.text = ""
        doShowMenu = true
        showMenu()
    }
    
    override func viewDidAppear(didAppear: Bool) {
        super.viewDidAppear(didAppear)
        
        //Menu Reload Screen Reload
        if doShowMenu {
            doShowMenu = false
            showMenu()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showMenu(){
      
        view.endEditing(true)
        
        // Click/Upload Photo Menu
        let imagePickerActionSheet = UIAlertController(title: "Click/Upload Photo",
            message: nil, preferredStyle: .ActionSheet)
        
        // Take Photo Option
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
        
        // Choose Existing Option
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
        
        // Cancel Option
        let cancelButton = UIAlertAction(title: "Cancel",
            style: .Cancel) { (alert) -> Void in
                self.doShowMenu = true
        }
        imagePickerActionSheet.addAction(cancelButton)

        presentViewController(imagePickerActionSheet, animated: true,
            completion: nil)
    }
    
    @IBAction func takePhoto(sender: AnyObject) {
        
        view.endEditing(true)
        
        
        // Snap/Upload Photo Menu
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",
            message: nil, preferredStyle: .ActionSheet)
        
        // Take Photo Option
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
        
        // Choose Existing Option
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
        
        // Cancel Option
        let cancelButton = UIAlertAction(title: "Cancel",
            style: .Cancel) { (alert) -> Void in
                
        }
        imagePickerActionSheet.addAction(cancelButton)

        presentViewController(imagePickerActionSheet, animated: true,
            completion: nil)
    }
    
    
    //Method to scale image for OCR
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor: CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    // Activity Indicator methods
    
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
    }


  

}




extension CaptureBillViewController: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
            let scaledImage = scaleImage(selectedPhoto, maxDimension: 1000)
            
            addActivityIndicator()
            
            dismissViewControllerAnimated(true, completion: {
                self.performImageRecognition(scaledImage)
            })
    }
    
    
    func performImageRecognition(image: UIImage) {
        // 1
        let tesseract = G8Tesseract()
        
        // 2
        tesseract.language = "eng"
        
        // 3
        tesseract.engineMode = .TesseractCubeCombined
        
        // 4
        tesseract.pageSegmentationMode = .Auto
        
        // 5
        tesseract.maximumRecognitionTime = 60.0
        
        // 6
        tesseract.image = image.g8_blackAndWhite()
        tesseract.recognize()
        
        // 7
        textView.text = tesseract.recognizedText
        textView.editable = true
        
        addIngredientsToDB()
        
        // 8
        removeActivityIndicator()
    }
    
    func addIngredientsToDB(){
        
        //Reference to AppDelegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
       //Reference to Context
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        //to add
        let ingredient = NSEntityDescription.entityForName("AvailIngredients" , inManagedObjectContext: context)
        
        
        var listIngredientsDB: Array<AnyObject> = []

        let readIngredients = NSFetchRequest(entityName: "AvailIngredients")
        listIngredientsDB =   context.executeFetchRequest(readIngredients, error: nil)!
        
        var alreadyPresent : Bool = false
        var alreadyPresentIngredient: NSManagedObject!
        
        //String to Array
        var bill : String = textView.text
        var space : Int = 0
        var char = bill.subString(0, length: 1)
        var quantity : Int = -1
        var ingredientName : String = ""
        var newQuantity = ""
        
        var i: Int = 0
        while i < bill.length && bill.subString(i, length: 5) != "Total" {
             char = bill.subString(i, length: 1)
            var num = bill.subString(i, length: 1).toInt()
            if num != nil{
                // Found First Digit
                bill = bill.subString(i, length: bill.length - i)
                space = bill.indexOf(" ")
                num = bill.subString(0, length: space).toInt()
                quantity = num!
                i = space
            }
            else{
                //Quantity already stored
                if quantity != -1{
                    //Store Ingredient name
                    bill = bill.subString(i, length: bill.length - i)
                    space = bill.indexOf(" ")
                    ingredientName = bill.subString(0, length: space)
                    i = bill.indexOf("\n") + 1
                    bill = bill.subString(i, length: bill.length - i)
                    i = -1
                    
                    for item in listIngredientsDB
                    {
                        if(item.name == ingredientName)
                        {
                         
                            alreadyPresentIngredient = item as! NSManagedObject
                           
                        }
                    }
                    
                    if (alreadyPresentIngredient != nil)
                    {
                        //update existing ingredient
                        alreadyPresentIngredient.setValue(ingredientName, forKey: "name")
                        alreadyPresentIngredient.setValue(alreadyPresentIngredient.valueForKey("unit"), forKey: "unit")
                        
                        
                        var newValue = quantity.description.toInt()
                        var oldValue = (alreadyPresentIngredient.valueForKey("quantity") as! String).toInt()
                 
                        
                        var finalValue = newValue! + oldValue!
                   
                        alreadyPresentIngredient.setValue(String(finalValue), forKey: "quantity")
                        alreadyPresentIngredient = nil
                    }
                    else
                    {
                    // Add new ingredient in DB
                    //Create instance of data model
                    var newIngredient = AvailIngredients(entity:ingredient!, insertIntoManagedObjectContext: context)
                    
                    
                    //map properties
                    newIngredient.name = ingredientName
                    newIngredient.quantity = quantity.description
                    newIngredient.unit = ""
                    
                    }
                    
                    //Post DB Insertion
                    quantity = -1
                    ingredientName = ""
                }
                
                //save context
                context.save(nil)
            }
            i++
        }
       
        
        
        
        let alert = UIAlertView()
        alert.title = "Bill Captured"
        alert.message = "Items have been added to your Available Ingredients list."
        alert.addButtonWithTitle("Ok")
        alert.show()
        
        doShowMenu = true

    }
    
}




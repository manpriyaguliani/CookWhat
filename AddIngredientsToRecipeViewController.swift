//
//  AddIngredientsToRecipeViewController.swift
//  CookWhat
//
//  Created by MCP 2015 on 24/07/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData


class AddIngredientsToRecipeViewController: UIViewController, UITableViewDataSource, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    
    var photoPath : String!
    
    @IBOutlet weak var ingredientAddedTable: UITableView!
    var list: [String] = []//["1","2","03"]
    @IBOutlet weak var ingredientName: UITextField!
    
    @IBOutlet weak var ingreditentQuantity: UITextField!
    
    
    @IBOutlet weak var photoPreview: UIImageView!
    
    @IBAction func addPhoto(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
        
        picker.delegate = self
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func saveData(sender: AnyObject) {
        
        //Reference to AppDelegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        //Reference to Context
        let contxt:NSManagedObjectContext = appDel.managedObjectContext!
        
        let rec = NSEntityDescription.entityForName("Recipes" , inManagedObjectContext: contxt)
        let ingr = NSEntityDescription.entityForName("Ingredients" , inManagedObjectContext: contxt)
        
        
        //Create instance of data model
        var newRecipe = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
 
        
        
        // UIImage recipeImage = "sampleImage.jpg" as UIImage;
        
        //  NSData dataImage = UIImageJPEGRepresentation(recipeImage, 0.0);
        
        
        
        //map properties
        
        newRecipe.title = "ImageRecipe"
        newRecipe.servings = "ImageRecipe"
        newRecipe.method = "ImageRecipe"
        newRecipe.duration = "ImageRecipe"
        
        
        if(self.photoPath != nil)
        {
            newRecipe.photoPath = photoPath
        }
        else
        {
            let URL : NSString = NSURL(fileURLWithPath: "/no-recipe-image.jpg")!.absoluteString!
          newRecipe.photoPath = URL as String
        }
        
       
        
        
        //save context
        contxt.save(nil)
        
        
        //navigate back to root Vc
        self.navigationController?.popToRootViewControllerAnimated(true)
        

        
        
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

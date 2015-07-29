//
//  AppDelegate.swift
//  CookWhat
//
//  Created by Sarah Suleri on 10/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var existingRecipeList: Array<AnyObject> = []


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "Recipes")
       // let fetchIngr = NSFetchRequest(entityName: "Ingredients")
        existingRecipeList =   context.executeFetchRequest(freq, error: nil)!
        //myIngrList =   context.executeFetchRequest(fetchIngr, error: nil)!
        
        if(existingRecipeList.count == 0)
        {
              preloadData()
        }
            return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack
    
    
    func preloadData()
    {
        //Reference to AppDelegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        //Reference to Context
        let contxt:NSManagedObjectContext = appDel.managedObjectContext!
        
        let rec = NSEntityDescription.entityForName("Recipes" , inManagedObjectContext: contxt)
        let ingr = NSEntityDescription.entityForName("Ingredients" , inManagedObjectContext: contxt)
        
        let ingredients = NSEntityDescription.entityForName("AvailIngredients" , inManagedObjectContext: contxt)
        
        //pre-loaded data for available ingredients table
        var ingredient1 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient1.name = "Milk"
        ingredient1.quantity = "2"
        ingredient1.unit = "Litre"
        
        var ingredient2 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient2.name = "Apples"
        ingredient2.quantity = "6"
        ingredient2.unit = ""

        
        var ingredient3 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient3.name = "Butter"
        ingredient3.quantity = "2"
        ingredient3.unit = "Cup"
        
        var ingredient4 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient4.name = "Eggs"
        ingredient4.quantity = "6"
        ingredient4.unit = ""

        var ingredient5 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient5.name = "Salt"
        ingredient5.quantity = "10"
        ingredient5.unit = "Tsp"
        
        var ingredient6 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient6.name = "Pasta"
        ingredient6.quantity = "1000"
        ingredient6.unit = "g"
        
        var ingredient7 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient7.name = "Chocolate"
        ingredient7.quantity = "10"
        ingredient7.unit = ""
        
        var ingredient8 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient8.name = "Sugar"
        ingredient8.quantity = "1000"
        ingredient8.unit = "g"
        
        var ingredient9 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient9.name = "Potato"
        ingredient9.quantity = "10"
        ingredient9.unit = ""
        
        
        var ingredient10 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient10.name = "Carrot"
        ingredient10.quantity = "5"
        ingredient10.unit = " "
        
        var ingredient11 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient11.name = "Honey"
        ingredient11.quantity = "5"
        ingredient11.unit = "Tsp"
        
        var ingredient12 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient12.name = "Avocado"
        ingredient12.quantity = "5"
        ingredient12.unit = " "
        
        var ingredient13 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient13.name = "Banana"
        ingredient13.quantity = "6"
        ingredient13.unit = " "
        
        
        
        //pre-loaded data for recipe and ingredient table
        var Recipe1 = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
        var Recipe1Ingredient1 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe1Ingredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe1Ingredient3 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        
        var Recipe2 = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
        var Recipe2Ingredient1 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe2Ingredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe2Ingredient3 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        
        var Recipe3 = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
        var Recipe3Ingredient1 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe3Ingredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe3Ingredient3 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe3Ingredient4 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        
        var Recipe4 = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
        var Recipe4Ingredient1 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe4Ingredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe4Ingredient3 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe4Ingredient4 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        
        var Recipe5 = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
        var Recipe5Ingredient1 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe5Ingredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe5Ingredient3 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe5Ingredient4 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        
        var Recipe6 = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
        var Recipe6Ingredient1 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe6Ingredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe6Ingredient3 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe6Ingredient4 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        
        var Recipe7 = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
        var Recipe7Ingredient1 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe7Ingredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe7Ingredient3 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        
        var Recipe8 = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
        var Recipe8Ingredient1 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe8Ingredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var Recipe8Ingredient3 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
     
        
        
        
        
        
        
        
        //Easy Dinner Rolls
        
        Recipe1.title = "Easy Dinner Rolls"
        Recipe1.servings = "2"
        Recipe1.method = "Combine water and yeast in lg bowl; let stand for 5 minutes.        With wooden spoon, stir  butter, sugar, eggs and salt.         Add flour, 1 cup at a time and beat  much  you can.      (you will probably be able to use all the flour) Cover and refrigerate  at least 2 hours, or up to 3 days.         Grease a 13x9 baking pan.         Turn dough out onto floured surface.         Divide into 24 equal pieces.         Roll each piece into a smooth round ball.         Place  rows  prepared pan.         Cover and  rise  1 hour; until doubled."
        Recipe1.duration = "20"
        let path : NSString = NSURL(fileURLWithPath: "dinner_rolls.jpg")!.absoluteString!
        Recipe1.photoPath = path as String
        Recipe1.isFavourite = "true"
        
        Recipe1Ingredient1.name = "Butter"
        Recipe1Ingredient1.priority = "high"
        Recipe1Ingredient1.quantity = "1"
        Recipe1Ingredient1.unit = "Cup"
        Recipe1Ingredient1.recipe = Recipe1
        
        Recipe1Ingredient2.name = "Eggs"
        Recipe1Ingredient2.priority = "high"
        Recipe1Ingredient2.quantity = "3"
        Recipe1Ingredient2.unit = " "
        Recipe1Ingredient2.recipe = Recipe1
        
        Recipe1Ingredient3.name = "Salt"
        Recipe1Ingredient3.priority = "medium"
        Recipe1Ingredient3.quantity = "1"
        Recipe1Ingredient3.unit = "Tsp"
        Recipe1Ingredient3.recipe = Recipe1
        
        
        //Shrimp, Leek, and Spinach Pasta
        
        Recipe2.title = "Shrimp, Leek, and Spinach Pasta"
        Recipe2.servings = "4"
        Recipe2.method = " Cook the pasta according to the package directions; drain and return it to the pot.    Meanwhile, heat the butter in a large skillet over medium heat. Add the leeks, ½ teaspoon salt, and ¼ teaspoon pepper and cook, stirring occasionally, until the leeks have softened, 3 to 5 minutes.         Add the shrimp and lemon zest and cook, tossing frequently, until the shrimp  opaque throughout, 4 to 5 minutes more.         Add the cream and ½ teaspoon salt to the pasta the pot and cook over medium heat, stirring, until slightly thickened, 1 to 2 minutes. Add the shrimp mixture and the spinach and toss to combine."
        let path1 : NSString = NSURL(fileURLWithPath: "shrimp-leek-pasta_300.jpg")!.absoluteString!
        Recipe2.photoPath = path1 as String
        Recipe2.isFavourite = "true"

        
        Recipe2.duration = "20"
        
        Recipe2Ingredient1.name = "Pasta"
        Recipe2Ingredient1.priority = "high"
        Recipe2Ingredient1.quantity = "1"
        Recipe2Ingredient1.unit = "Pound"
        Recipe2Ingredient1.recipe = Recipe2
        
        Recipe2Ingredient2.name = "Spinach"
        Recipe2Ingredient2.priority = "high"
        Recipe2Ingredient2.quantity = "10"
        Recipe2Ingredient2.unit = "Ounce"
        Recipe2Ingredient2.recipe = Recipe2
        
        Recipe2Ingredient3.name = "Lemon"
        Recipe2Ingredient3.priority = "low"
        Recipe2Ingredient3.quantity = "1"
        Recipe2Ingredient3.unit = " "
        Recipe2Ingredient3.recipe = Recipe2
        
        
        
        //Eggplant With Peppers and Beans Sandwich
        
        Recipe3.title = "Eggplant With Peppers and Beans Sandwich"
        Recipe3.servings = "4"
        Recipe3.method = "Heat oven to 400° F. Place the eggplant on 2 rimmed baking sheets and brush with ¼ cup of the oil. Season with the cayenne and ¼ teaspoon salt and bake, turning once,  until tender, 20 to 25 minutes. Let cool.  Meanwhile, mash the beans, garlic, tahini, lemon juice, the remaining tablespoon of oil, ¼ teaspoon salt, and ¼ teaspoon black pepper in a small bowl.         Divide the mashed beans, eggplant, red peppers, and romaine leaves among the bread."
        let path2 : NSString = NSURL(fileURLWithPath: "bean_sandwich.jpg")!.absoluteString!
        Recipe3.photoPath = path2 as String

        Recipe3.isFavourite = "true"
        Recipe3.duration = "15"
        
        Recipe3Ingredient1.name = "Eggplant"
        Recipe3Ingredient1.priority = "high"
        Recipe3Ingredient1.quantity = "1"
        Recipe3Ingredient1.unit = ""
        Recipe3Ingredient1.recipe = Recipe3
        
        Recipe3Ingredient2.name = "Olive oil"
        Recipe3Ingredient2.priority = "high"
        Recipe3Ingredient2.quantity = "1"
        Recipe3Ingredient2.unit = "Cup"
        Recipe3Ingredient2.recipe = Recipe3
        
        Recipe3Ingredient3.name = "Foccacia"
        Recipe3Ingredient3.priority = "high"
        Recipe3Ingredient3.quantity = "8"
        Recipe3Ingredient3.unit = "Slice"
        Recipe3Ingredient3.recipe = Recipe3
        
        Recipe3Ingredient4.name = "Tahini"
        Recipe3Ingredient4.priority = "medium"
        Recipe3Ingredient4.quantity = "1"
        Recipe3Ingredient4.unit = "Tbsp"
        Recipe3Ingredient4.recipe = Recipe3
        
     
        
        
        //Easy Chicken and Dumplings
        
        Recipe4.title = "Easy Chicken and Dumplings"
        Recipe4.servings = "4"
        Recipe4.method = "In 4- to 5-quart Dutch oven, heat broth, chicken, soup and poultry seasoning to boiling over medium-high heat; reduce heat to low. Cover; simmer 5 minutes, stirring occasionally. Increase heat to medium-high; return to a low boil.        On lightly floured surface, roll or pat each biscuit to 1/8-inch thickness; cut into 1/2-inch-wide strips         Drop strips, one at a time, into boiling chicken mixture.Add carrots and celery. Reduce heat to low Cover; simmer 15 to 20 minutes, stirring occasionally to prevent dumplings from sticking."
        let path3 : NSString = NSURL(fileURLWithPath: "chicken_dumplings.jpg")!.absoluteString!
        Recipe4.photoPath = path3 as String
        
        Recipe4.isFavourite = "true"
        Recipe4.duration = "40"
        
        Recipe4Ingredient1.name = "Chicken"
        Recipe4Ingredient1.priority = "high"
        Recipe4Ingredient1.quantity = "3"
        Recipe4Ingredient1.unit = "Cup"
        Recipe4Ingredient1.recipe = Recipe4
        
        Recipe4Ingredient2.name = "Biscuits"
        Recipe4Ingredient2.priority = "high"
        Recipe4Ingredient2.quantity = "15"
        Recipe4Ingredient2.unit = " "
        Recipe4Ingredient2.recipe = Recipe4
        
        Recipe4Ingredient3.name = "Carrots"
        Recipe4Ingredient3.priority = "medium"
        Recipe4Ingredient3.quantity = "2"
        Recipe4Ingredient3.unit = " "
        Recipe4Ingredient3.recipe = Recipe4
        
        Recipe4Ingredient4.name = "Condensed Milk"
        Recipe4Ingredient4.priority = "low"
        Recipe4Ingredient4.quantity = "1"
        Recipe4Ingredient4.unit = " "
        Recipe4Ingredient4.recipe = Recipe4
        
        
        
        //Mint Green Smoothie
        
        Recipe5.title = "Mint Green Smoothie"
        Recipe5.servings = "1"
        Recipe5.method = "Place all the ingredients into a blender and blend until smooth and combined. Pour into glasses and serve."
        let path4 : NSString = NSURL(fileURLWithPath: "green-smoothie-picture.jpg")!.absoluteString!
        Recipe5.photoPath = path4 as String
        
        Recipe5.isFavourite = "true"
        Recipe5.duration = "5"
        
        Recipe5Ingredient1.name = "Milk"
        Recipe5Ingredient1.priority = "high"
        Recipe5Ingredient1.quantity = "1"
        Recipe5Ingredient1.unit = "Cup"
        Recipe5Ingredient1.recipe = Recipe5
        
        Recipe5Ingredient2.name = "Avocado"
        Recipe5Ingredient2.priority = "high"
        Recipe5Ingredient2.quantity = "1"
        Recipe5Ingredient2.unit = " "
        Recipe5Ingredient2.recipe = Recipe5
        
        Recipe5Ingredient3.name = "Banana"
        Recipe5Ingredient3.priority = "medium"
        Recipe5Ingredient3.quantity = "1"
        Recipe5Ingredient3.unit = " "
        Recipe5Ingredient3.recipe = Recipe5
        
        Recipe5Ingredient4.name = "Honey"
        Recipe5Ingredient4.priority = "medium"
        Recipe5Ingredient4.quantity = "2"
        Recipe5Ingredient4.unit = "Tsp"
        Recipe5Ingredient4.recipe = Recipe5
        
        
        //Cheese, carrot & Ham Wrap
        
        Recipe6.title = "Cheese, Cream & Ham Wrap"
        Recipe6.servings = "1"
        Recipe6.method = "Spread the wrap with the cream cheese. Arrange the ham on top. Place the avocado slices in a straight line across the middle. Season with salt and pepper. Top with the carrot. Roll up the wrap tightly to enclose. Cut in half."
        let path5 : NSString = NSURL(fileURLWithPath: "cheese_wrap.jpg")!.absoluteString!
        Recipe6.photoPath = path5 as String
                Recipe6.isFavourite = "true"
        Recipe6.duration = "5"
        
        Recipe6Ingredient1.name = "Bread Wrap"
        Recipe6Ingredient1.priority = "high"
        Recipe6Ingredient1.quantity = "1"
        Recipe6Ingredient1.unit = " "
        Recipe6Ingredient1.recipe = Recipe6
        
        Recipe6Ingredient2.name = "Cheese"
        Recipe6Ingredient2.priority = "high"
        Recipe6Ingredient2.quantity = "1"
        Recipe6Ingredient2.unit = "Tbsp"
        Recipe6Ingredient2.recipe = Recipe6
        
        Recipe6Ingredient3.name = "Ham"
        Recipe6Ingredient3.priority = "High"
        Recipe6Ingredient3.quantity = "1"
        Recipe6Ingredient3.unit = "Kg"
        Recipe6Ingredient3.recipe = Recipe6
        
        Recipe6Ingredient4.name = "Carrot"
        Recipe6Ingredient4.priority = "High"
        Recipe6Ingredient4.quantity = "1"
        Recipe6Ingredient4.unit = " "
        Recipe6Ingredient4.recipe = Recipe6
        
        
        //Potato, carrots and Pasta
        
        Recipe7.title = "Potato, carrots and Pasta"
        Recipe7.servings = "2"
        Recipe7.method = "Boil all vegetables and pasta separately. Mix both, add salt and pepper to taste. You are good to go."
        let path6 : NSString = NSURL(fileURLWithPath: "carrot_pasta.jpg")!.absoluteString!
        Recipe7.photoPath = path6 as String
        Recipe7.isFavourite = "true"
        Recipe7.duration = "10"
        
        Recipe7Ingredient1.name = "Potato"
        Recipe7Ingredient1.priority = "high"
        Recipe7Ingredient1.quantity = "2"
        Recipe7Ingredient1.unit = " "
        Recipe7Ingredient1.recipe = Recipe7
        
        Recipe7Ingredient2.name = "Carrot"
        Recipe7Ingredient2.priority = "high"
        Recipe7Ingredient2.quantity = "2"
        Recipe7Ingredient2.unit = " "
        Recipe7Ingredient2.recipe = Recipe7
        
        Recipe7Ingredient3.name = "Pasta"
        Recipe7Ingredient3.priority = "High"
        Recipe7Ingredient3.quantity = "100"
        Recipe7Ingredient3.unit = "g"
        Recipe7Ingredient3.recipe = Recipe7
        
        
        //Hot Chocolate
        
        Recipe8.title = "Hot Chocolate"
        Recipe8.servings = "1"
        Recipe8.method = "Melt chocolate in a pan. Slowly add milk while stirring. Add sugar when boiled. Pour in a glass."
        let path7 : NSString = NSURL(fileURLWithPath: "hot_chocolate.jpg")!.absoluteString!
        Recipe8.photoPath = path7 as String
        Recipe8.isFavourite = "true"
        Recipe8.duration = "8"
        
        Recipe8Ingredient1.name = "Milk"
        Recipe8Ingredient1.priority = "high"
        Recipe8Ingredient1.quantity = "1"
        Recipe8Ingredient1.unit = "Cup"
        Recipe8Ingredient1.recipe = Recipe8
        
        Recipe8Ingredient2.name = "Chocolate"
        Recipe8Ingredient2.priority = "high"
        Recipe8Ingredient2.quantity = "2"
        Recipe8Ingredient2.unit = " "
        Recipe8Ingredient2.recipe = Recipe8
        
        Recipe8Ingredient3.name = "Sugar"
        Recipe8Ingredient3.priority = "Medium"
        Recipe8Ingredient3.quantity = "1"
        Recipe8Ingredient3.unit = "Tsp"
        Recipe8Ingredient3.recipe = Recipe8
        
        
        
        
        
        
        
        //save context
        contxt.save(nil)
        
        
    }
    
    

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "mcp.CookWhat" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("CookWhat", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("CookWhat.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

}


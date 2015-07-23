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
  //
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
        
        
        var ingredient1 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient1.name = "Milk"
        ingredient1.quantity = "1"
        ingredient1.unit = "litre"
        
        var ingredient2 = AvailIngredients(entity:ingredients!, insertIntoManagedObjectContext: contxt)
        
        ingredient2.name = "Eggs"
        ingredient2.quantity = "6"
        ingredient2.unit = ""
        
        
        
        
        
        //Create instance of data model
        var newRecipe = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
        var newIngredient = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var newIngredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var newIngredient3 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        
        var Recipe2 = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
        var nRecipe2Ingredient1 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var nRecipe2Ingredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var nRecipe2Ingredient3 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        
        var Recipe3 = Recipes(entity:rec!, insertIntoManagedObjectContext: contxt)
        var nRecipe3Ingredient1 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var nRecipe3Ingredient2 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var nRecipe3Ingredient3 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        var nRecipe3Ingredient4 = Ingredients(entity:ingr!, insertIntoManagedObjectContext: contxt)
        
        //map properties
        
        newRecipe.title = "Easy Dinner Rolls"
        newRecipe.servings = "2"
        newRecipe.method = "Combine water and yeast in lg bowl; let stand for 5 minutes.        With wooden spoon, stir  butter, sugar, eggs and salt.         Add flour, 1 cup at a time and beat  much  you can.      (you will probably be able to use all the flour) Cover and refrigerate  at least 2 hours, or up to 3 days.         Grease a 13x9 baking pan.         Turn dough out onto floured surface.         Divide into 24 equal pieces.         Roll each piece into a smooth round ball.         Place  rows  prepared pan.         Cover and  rise  1 hour; until doubled."
        newRecipe.duration = "20"
        
        newIngredient.name = "Butter"
        newIngredient.priority = "high"
        newIngredient.quantity = "1/2"
        newIngredient.unit = "cup"
        newIngredient.recipe = newRecipe
        
        newIngredient2.name = "eggs"
        newIngredient2.priority = "high"
        newIngredient2.quantity = "3"
        newIngredient2.unit = " "
        newIngredient2.recipe = newRecipe
        
        newIngredient3.name = "salt"
        newIngredient3.priority = "medium"
        newIngredient3.quantity = "1"
        newIngredient3.unit = "tsp"
        newIngredient3.recipe = newRecipe
        
        
        
        
        Recipe2.title = "Shrimp, Leek, and Spinach Pasta"
        Recipe2.servings = "4"
        Recipe2.method = " Cook the pasta according to the package directions; drain and return it to the pot.    Meanwhile, heat the butter in a large skillet over medium heat. Add the leeks, ½ teaspoon salt, and ¼ teaspoon pepper and cook, stirring occasionally, until the leeks have softened, 3 to 5 minutes.         Add the shrimp and lemon zest and cook, tossing frequently, until the shrimp  opaque throughout, 4 to 5 minutes more.         Add the cream and ½ teaspoon salt to the pasta the pot and cook over medium heat, stirring, until slightly thickened, 1 to 2 minutes. Add the shrimp mixture and the spinach and toss to combine."
        
        
        Recipe2.duration = "20"
        
        nRecipe2Ingredient1.name = "Pasta"
        nRecipe2Ingredient1.priority = "high"
        nRecipe2Ingredient1.quantity = "3/4"
        nRecipe2Ingredient1.unit = "pound"
        nRecipe2Ingredient1.recipe = Recipe2
        
        nRecipe2Ingredient2.name = "Spinach"
        nRecipe2Ingredient2.priority = "high"
        nRecipe2Ingredient2.quantity = "10"
        nRecipe2Ingredient2.unit = "ounces"
        nRecipe2Ingredient2.recipe = Recipe2
        
        nRecipe2Ingredient3.name = "lemon"
        nRecipe2Ingredient3.priority = "low"
        nRecipe2Ingredient3.quantity = "1"
        nRecipe2Ingredient3.unit = " "
        nRecipe2Ingredient3.recipe = Recipe2
        
        
        
        //Eggplant With Peppers and Beans Sandwich
        
        Recipe3.title = "Eggplant With Peppers and Beans Sandwich"
        Recipe3.servings = "4"
        Recipe3.method = "Heat oven to 400° F. Place the eggplant on 2 rimmed baking sheets and brush with ¼ cup of the oil. Season with the cayenne and ¼ teaspoon salt and bake, turning once,  until tender, 20 to 25 minutes. Let cool.  Meanwhile, mash the beans, garlic, tahini, lemon juice, the remaining tablespoon of oil, ¼ teaspoon salt, and ¼ teaspoon black pepper in a small bowl.         Divide the mashed beans, eggplant, red peppers, and romaine leaves among the bread."
        
        
        Recipe3.duration = "15"
        
        nRecipe3Ingredient1.name = "Eggplant"
        nRecipe3Ingredient1.priority = "high"
        nRecipe3Ingredient1.quantity = "1"
        nRecipe3Ingredient1.unit = ""
        nRecipe3Ingredient1.recipe = Recipe3
        
        nRecipe3Ingredient2.name = "olive oil"
        nRecipe3Ingredient2.priority = "high"
        nRecipe3Ingredient2.quantity = "1/2"
        nRecipe3Ingredient2.unit = "Cup"
        nRecipe3Ingredient2.recipe = Recipe3
        
        nRecipe3Ingredient3.name = "foccacia"
        nRecipe3Ingredient3.priority = "high"
        nRecipe3Ingredient3.quantity = "8"
        nRecipe3Ingredient3.unit = "slices"
        nRecipe3Ingredient3.recipe = Recipe3
        
        nRecipe3Ingredient4.name = "Tahini"
        nRecipe3Ingredient4.priority = "medium"
        nRecipe3Ingredient4.quantity = "1"
        nRecipe3Ingredient4.unit = "tbsp"
        nRecipe3Ingredient4.recipe = Recipe3
        
        
        
        
        
        println(newRecipe)
        println(newIngredient)
        println("..........")
        println(newIngredient.recipe)
        println("..........")
        
        
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


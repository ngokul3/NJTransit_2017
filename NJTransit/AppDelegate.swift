//
//  AppDelegate.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 8/13/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import UIKit
import CoreData



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
          //  preloadData()
       // populateTest()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "GokulNarasimhan.NJTransit" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "NJTransit", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        
      
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("NJTransit.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            var optionsPersistent = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true, NSSQLitePragmasOption: ["journal_mode": "DELETE"]] as [String : Any]
   
            
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    
    func parseCSV (_ contentsOfURL: URL, encoding: String.Encoding) -> [(stopID:String, stopCode:String, stopName: String, stopDesc: String, stopLat: String, stopLong: String, zoneID: String)]? {
        
        // Load the CSV file and parse it
        let delimiter = ","
        var items:[(stopID:String, stopCode:String, stopName: String, stopDesc: String, stopLat: String, stopLong: String, zoneID: String)]?
        
        do {
            let content = try String(contentsOf: contentsOfURL, encoding: encoding)
            
       //     if let data = NSData(contentsOfURL: contentsOfURL) {
         //       if let content = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    
                   
                   // let x2 = try String(contentsOfURL: contentsOfURL, usedEncoding: nil)
                    
                    print(content)
                    items = []
                    let lines:[String] = content.components(separatedBy: CharacterSet.newlines) as [String]
                    
                    for line in lines {
                        var values:[String] = []
                        if line != "" {
                            // For a line with double quotes
                            // we use NSScanner to perform the parsing
                            if line.range(of: "\"") != nil {
                                var textToScan:String = line
                                var value:NSString?
                                var textScanner:Scanner = Scanner(string: textToScan)
                                while textScanner.string != "" {
                                    
                                    if (textScanner.string as NSString).substring(to: 1) == "\"" {
                                        textScanner.scanLocation += 1
                                        textScanner.scanUpTo("\"", into: &value)
                                        textScanner.scanLocation += 1
                                    } else {
                                        textScanner.scanUpTo(delimiter, into: &value)
                                    }
                                    
                                    // Store the value into the values array
                                    values.append(value as! String)
                                    
                                    // Retrieve the unscanned remainder of the string
                                    if textScanner.scanLocation < textScanner.string.characters.count {
                                        textToScan = (textScanner.string as NSString).substring(from: textScanner.scanLocation + 1)
                                    } else {
                                        textToScan = ""
                                    }
                                    textScanner = Scanner(string: textToScan)
                                }
                                
                                // For a line without double quotes, we can simply separate the string
                                // by using the delimiter (e.g. comma)
                            } else  {
                                values = line.components(separatedBy: delimiter)
                            }
                            
                            // Put the values into the tuple and add it to the items array
                            let item = (stopID: values[0], stopCode: values[1], stopName: values[2], stopDesc: values[3], stopLat: values[4], stopLong: values[5], zoneID: values[6])
                            items?.append(item)
                        }
                    }
                    
                    //existing code
                //}
            //}
            
            
          
            
        } catch {
            print(error)
        }
        
        return items
    }
    
    func preloadData () {
        
        // Load the data file. For any reasons it can't be loaded, we just return
        guard let remoteURL = URL(string: "https://48b1e1407476891c02da38520d77264d635be7f2.googledrive.com/host/0B-1jRhZF8VZfZFpfTG1sUG9GWlk/stops.csv") else {
            return
        }
        
        // Remove all the menu items before preloading
   //     removeData()
        
        if let items = parseCSV(remoteURL, encoding: String.Encoding.utf8) {
            // Preload the menu items
            for item in items {
                let stop = NSEntityDescription.insertNewObject(forEntityName: "Stop", into: managedObjectContext) as! Stop
                stop.stopID  = (item.stopID as NSString).intValue
                stop.stopCode = item.stopCode
                stop.stopName = item.stopName
                stop.stopDesc = item.stopDesc
                stop.stopLat = (item.stopLat as NSString).doubleValue
                stop.stopLong = (item.stopLong as NSString).doubleValue
                stop.zoneID = (item.zoneID as NSString).intValue
                stop.transitType = TransitType.bus.description
              //  menuItem.price = (item.price as NSString).doubleValue
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
            
        }
    }
    
    func populateTest()
    {
        
        guard let storeURL = URL(string: "https://48b1e1407476891c02da38520d77264d635be7f2.googledrive.com/host/0B-1jRhZF8VZfZFpfTG1sUG9GWlk/NJTransit.sqlite") else {
            return
        }
      /*
        Alamofire.request(.GET, storeURL).response() {
            (_, _, data, _) in
            print("inside")
            print(data)
        }
        
        
        Alamofire.request(
            .GET,
            "https://48b1e1407476891c02da38520d77264d635be7f2.googledrive.com/host/0B-1jRhZF8VZfZFpfTG1sUG9GWlk/NJTransit.sqlite",
            parameters: ["include_docs": "true"],
            encoding: .URL)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(response.result.error)")
                  //  completion(nil)
                    return
                }
                
                guard let value = response.result.value as? [String: AnyObject],
                    rows = value["rows"] as? [[String: AnyObject]] else {
                        print("Malformed data received from fetchAllRooms service")
                      //  completion(nil)
                        return
                }
                
                for roomDict in rows {
                    print(roomDict)
                }
                
               // completion(rooms)
        }
        
       */
        
    }
    
    func populateDBFromDrive()
    {
        guard let storeURL = URL(string: "https://48b1e1407476891c02da38520d77264d635be7f2.googledrive.com/host/0B-1jRhZF8VZfZFpfTG1sUG9GWlk/NJTransit.sqlite") else {
            return
        }
        
        let fileManager = FileManager.default
        let error: NSError!
        
        print(storeURL.path)
        
        if fileManager.fileExists(atPath: storeURL.path) {
            let storeDirectory = storeURL.deletingLastPathComponent()
            let enumerator = fileManager.enumerator(at: storeDirectory, includingPropertiesForKeys: nil, options: [], errorHandler: nil)
          /*  var storeName = storeURL.lastPathComponent!.url
            for url: NSURL in enumerator! {
                if url.lastPathComponent.hasPrefix(storeName) {
                    
                }
                do {
                    (try fileManager!.removeItemAtURL(url!))
                }
                catch let error {
                }
            }*/
            // handle error
        }
        let bundleDbPath = Bundle.main.path(forResource: "LocalDatabase", ofType: "sqlite")!
        do {
            try fileManager.copyItem(atPath: bundleDbPath, toPath: storeURL.path)
        }
        catch _ {
        }

    }
    
  /*  func removeData () {
        // Remove the existing items
        let fetchRequest = NSFetchRequest(entityName: "Stop")
        
        do {
            let stops = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Stop]
            for stop in stops {
                managedObjectContext.deleteObject(stop)
            }
        } catch {
            print(error)
        }
        
    }*/


}


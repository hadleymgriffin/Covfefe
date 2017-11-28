
//
//  favShopCoreData.swift
//  Covfefe
//
//  Created by Hadley Griffin on 11/18/17.
//  Copyright © 2017 asu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class favShopCoreData {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchResults =   [FavoriteShop]()
    
    func save (name: String, phone: String, url: String)
    {
        let ent = NSEntityDescription.entity(forEntityName: "FavoriteShop", in: self.managedObjectContext)
        
        let favShop = FavoriteShop(entity: ent!, insertInto: managedObjectContext)
        
        
        favShop.name = name
        favShop.website = url
        favShop.phone = phone
        
        do {
            try managedObjectContext.save()
            
        } catch let error {
           
        }
    }
    
    func fetchRecord() -> Int {
        // Create a new fetch request using the PlaceEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteShop")
        var x   = 0
        // Execute the fetch request, and cast the results to an array of PlaceEnity objects
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [FavoriteShop])!
        
        
        x = fetchResults.count
        
        print(x)
        
        // return how many entities in the coreData
        return x
        
        
    }
    
    func find(sentName: String) -> (name: String, phone: String, url: String) {
        var name : String = ""
        var phone : String = ""
        var url : String = ""
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "FavoriteShop", in: managedObjectContext)
        
        let request: NSFetchRequest<FavoriteShop> = FavoriteShop.shopFetchRequest() as! NSFetchRequest<FavoriteShop>
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(name = %@)", sentName)
        request.predicate = pred
        
        do {
            var results =
                try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                name = (match.value(forKey: "name") as? String)!
                phone = (match.value(forKey: "phone") as? String)!
                url = (match.value(forKey: "website") as? String)!
            }
            
        } catch let error {
            
        }
        
        return(name, phone, url)
    }

    
    
}

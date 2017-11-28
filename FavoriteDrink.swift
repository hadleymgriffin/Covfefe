//
//  FavoriteDrink+CoreDataProperties.swift
//  Covfefe
//
//  Created by Hadley Griffin on 11/19/17.
//  Copyright © 2017 asu. All rights reserved.
//

import Foundation
import CoreData


extension FavoriteDrink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteDrink> {
        return NSFetchRequest<FavoriteDrink>(entityName: "FavoriteDrink")
    }

    @NSManaged public var calories: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?

}

public class FavoriteDrink : NSManagedObject {
}

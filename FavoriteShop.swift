//
//  FavoriteShop+CoreDataProperties.swift
//  Covfefe
//
//  Created by Hadley Griffin on 11/18/17.
//  Copyright © 2017 asu. All rights reserved.
//

import Foundation
import CoreData


extension FavoriteShop {

    @nonobjc public class func shopFetchRequest() -> NSFetchRequest<FavoriteShop> {
        return NSFetchRequest<FavoriteShop>(entityName: "FavoriteShop")
    }

    @NSManaged public var website: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?

}


public class FavoriteShop : NSManagedObject {
}

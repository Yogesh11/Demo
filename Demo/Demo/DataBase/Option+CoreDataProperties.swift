//
//  Option+CoreDataProperties.swift
//  
//
//  Created by Yogesh on 9/16/18.
//
//

import Foundation
import CoreData


extension Option {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Option> {
        return NSFetchRequest<Option>(entityName: Constant.K_Entity.k_Option)
    }

    @NSManaged public var isEnable: Bool
    @NSManaged public var facilityId: String?
    @NSManaged public var name: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: String?

}

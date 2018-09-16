//
//  Facility+CoreDataProperties.swift
//  
//
//  Created by Yogesh on 9/16/18.
//
//

import Foundation
import CoreData


extension Facility {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Facility> {
        return NSFetchRequest<Facility>(entityName:Constant.K_Entity.k_Facility)
    }

    @NSManaged public var facilityId: String?
    @NSManaged public var name: String?
    @NSManaged public var answerId: String?

}

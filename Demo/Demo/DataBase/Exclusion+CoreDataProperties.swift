//
//  Exclusion+CoreDataProperties.swift
//  
//
//  Created by Yogesh on 9/16/18.
//
//

import Foundation
import CoreData


extension Exclusion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exclusion> {
        return NSFetchRequest<Exclusion>(entityName: Constant.K_Entity.k_exclusion)
    }

    @NSManaged public var facilityID: String?
    @NSManaged public var optionId: String?
    @NSManaged public var exclusions: Exclusions?

}

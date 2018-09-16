//
//  Exclusions+CoreDataProperties.swift
//  
//
//  Created by Yogesh on 9/16/18.
//
//

import Foundation
import CoreData


extension Exclusions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exclusions> {
        return NSFetchRequest<Exclusions>(entityName: Constant.K_Entity.k_exclusions)
    }

    @NSManaged public var exclusion: NSOrderedSet?

}

// MARK: Generated accessors for exclusion
extension Exclusions {

    @objc(insertObject:inExclusionAtIndex:)
    @NSManaged public func insertIntoExclusion(_ value: Exclusion, at idx: Int)

    @objc(removeObjectFromExclusionAtIndex:)
    @NSManaged public func removeFromExclusion(at idx: Int)

    @objc(insertExclusion:atIndexes:)
    @NSManaged public func insertIntoExclusion(_ values: [Exclusion], at indexes: NSIndexSet)

    @objc(removeExclusionAtIndexes:)
    @NSManaged public func removeFromExclusion(at indexes: NSIndexSet)

    @objc(replaceObjectInExclusionAtIndex:withObject:)
    @NSManaged public func replaceExclusion(at idx: Int, with value: Exclusion)

    @objc(replaceExclusionAtIndexes:withExclusion:)
    @NSManaged public func replaceExclusion(at indexes: NSIndexSet, with values: [Exclusion])

    @objc(addExclusionObject:)
    @NSManaged public func addToExclusion(_ value: Exclusion)

    @objc(removeExclusionObject:)
    @NSManaged public func removeFromExclusion(_ value: Exclusion)

    @objc(addExclusion:)
    @NSManaged public func addToExclusion(_ values: NSOrderedSet)

    @objc(removeExclusion:)
    @NSManaged public func removeFromExclusion(_ values: NSOrderedSet)

}

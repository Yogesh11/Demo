//
//  DataBaseManager.swift
//  Demo
//
//  Created by Yogesh on 9/16/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import CoreData

class DataBaseManager: NSObject {
    static let sharedManager  = DataBaseManager()

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Demo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        })
        return container
    }()


    func getAllFacility()->[Facility]? {
        return getEntityByName(entityName: Constant.K_Entity.k_Facility, predicate: nil) as? [Facility]
    }

    private func getAllExclusion()->[Exclusions]? {
        return getEntityByName(entityName: Constant.K_Entity.k_exclusions, predicate: nil) as? [Exclusions]
    }


    func saveFacility(facilityModel : FacilityModel)->Facility {
        var dbFacility : Facility!  = nil
        if let facility = getFacilityByID(facilityID: facilityModel.id) {
            dbFacility = updateFacility(facility: facility, facilityModel: facilityModel)
        } else{
            dbFacility = updateFacility(facility: insertEntity(entityName: Constant.K_Entity.k_Facility) as! Facility, facilityModel: facilityModel)
        }

        for (i,optionModel) in facilityModel.options.enumerated() {
            if let option  = getOptionBy(facilityID: facilityModel.id, optionID: optionModel.id) {
                updateOption(option: option, optionModel: optionModel, facilityID: facilityModel.id)
            } else{
                let option = insertEntity(entityName: Constant.K_Entity.k_Option) as! Option
                option.displayOrder = Int64(i)
                updateOption(option: option , optionModel: optionModel, facilityID: facilityModel.id)
            }
        }
        return dbFacility
    }

    func saveAnswer(facilityID : String , answerID : String) {
        if let facility = getFacilityByID(facilityID: facilityID) {
         let(enableExclusion, disableExclusion) = getExclusionOptions(selectedFacilityID: facilityID, selectedAnswerID: answerID, previousOptionID: facility.answerId)
            if let enableEx = enableExclusion{
                for exclusions in enableEx{
                    for exclusion in exclusions.exclusion! {
                      let exclusionEntity = exclusion as! Exclusion
                        if !(exclusionEntity.facilityID == facilityID && exclusionEntity.optionId == facility.answerId) {
                            enableOption(facilityID: exclusionEntity.facilityID!, optionID: exclusionEntity.optionId!, isEnable: true)
                        }

                    }
                }
            }
           facility.answerId = answerID
           saveContext()
            if let disbaleEx = disableExclusion{
                for exclusions in disbaleEx{
                    for exclusion in exclusions.exclusion! {
                        let exclusionEntity = exclusion as! Exclusion
                        if !(exclusionEntity.facilityID == facilityID && exclusionEntity.optionId == facility.answerId) {
                          enableOption(facilityID: exclusionEntity.facilityID!, optionID: exclusionEntity.optionId!, isEnable: false)
                        }
                    }
                }
            }
        }
    }

    private func getExclusionOptions(selectedFacilityID : String ,
                                     selectedAnswerID   : String,
                                     previousOptionID   : String?) -> ([Exclusions]?, [Exclusions]?){
        if let exclusionList = getAllExclusion() {
            var enableExclusion  = [Exclusions]()
            var disableExclusion = [Exclusions]()
            for exclusions in exclusionList {
                for exclusion in exclusions.exclusion! {
                    let exclusionRow = exclusion as! Exclusion
                    if exclusionRow.facilityID == selectedFacilityID {
                        if exclusionRow.optionId == selectedAnswerID {
                              disableExclusion.append(exclusions)
                        } else if let previousID = previousOptionID , exclusionRow.optionId == previousID {
                                enableExclusion.append(exclusions)
                        }
                    }
                }
            }
            return(enableExclusion, disableExclusion)
        }
        return(nil, nil)
    }

    func enableOption(facilityID : String , optionID : String, isEnable : Bool) {
        if let option = getOptionBy(facilityID: facilityID, optionID: optionID) {
            option.isEnable = isEnable
            saveContext()
        }

    }

    func deleteAllFacility(){
        deleteAllEntitiesRelatedWithName(entityName: Constant.K_Entity.k_Facility, predicate: nil)
        deleteAllEntitiesRelatedWithName(entityName: Constant.K_Entity.k_Option, predicate: nil)
        saveContext()
    }

    func deleteAllExclusion(){
        deleteAllEntitiesRelatedWithName(entityName: Constant.K_Entity.k_exclusions, predicate: nil)
        saveContext()
    }
    
    private func deleteAllEntitiesRelatedWithName(entityName : String, predicate : NSPredicate?) {
        let fetch        = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetch.predicate  = predicate
        let request      = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            _ = try persistentContainer.viewContext.execute(request)
        } catch{
        }
    }

    private func updateFacility(facility : Facility , facilityModel : FacilityModel) -> Facility{
        facility.facilityId = facilityModel.id
        facility.name       = facilityModel.name
        saveContext()
        return facility
    }

    private func updateOption(option : Option, optionModel : OptionModel, facilityID : String) {
        option.name  = optionModel.name
        option.id    = optionModel.id
        option.icon  = optionModel.icon
        option.facilityId =  facilityID
        saveContext()
    }
    /// Get Entity By Name
    fileprivate func getEntityByName(entityName : String,
                                     batchNum: Int = 0,
                                     batchSize: Int = 0,
                                     batchOffset: Int = 0,
                                     predicate : NSPredicate?,
                                     sortDescriptors : [NSSortDescriptor]? = nil) -> Array<NSManagedObject>? {
        // DispatchQueue.main.sync {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.fetchBatchSize = batchSize
        request.fetchLimit = batchNum
        request.fetchOffset = batchOffset
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        do {
            let result = try persistentContainer.viewContext.fetch(request) as? [NSManagedObject]
            if let entityStorage  = result {
                if entityStorage.isEmpty == false {
                    return entityStorage
                }
            }

        } catch {

        }
        return nil
    }

    func getFacilityByID(facilityID : String) -> Facility?{
        var facility : Facility? = nil
        let query = NSPredicate(format: "facilityId = %@", facilityID)
        let facilities = getEntityByName(entityName: Constant.K_Entity.k_Facility, predicate: query)
        if let facilitiesRows = facilities , facilitiesRows.count > 0 {
            facility  = facilitiesRows.last as? Facility
        }
        return facility
    }

    private func getOptionBy(facilityID : String , optionID : String) -> Option?{
        var option : Option? = nil
        let query = NSPredicate(format: "facilityId = %@ && id = %@", facilityID, optionID)
        let options = getEntityByName(entityName: Constant.K_Entity.k_Option, predicate: query)
        if let optionsRow = options , optionsRow.count > 0 {
            option  = optionsRow.last as? Option
        }
        return option
    }

    func getOptionsBy(facilityID : String) -> [Option] {
        let query = NSPredicate(format: "facilityId = %@", facilityID)
         let sortDesriptor = NSSortDescriptor(key: #keyPath(Option.displayOrder), ascending: true)
        let options = getEntityByName(entityName: Constant.K_Entity.k_Option, predicate: query, sortDescriptors: [sortDesriptor])
        return (options ?? []) as! [Option]
    }

    func saveExclustion(exclusionList : ExclusionList) -> Exclusions {
        let exclusions  = insertEntity(entityName: Constant.K_Entity.k_exclusions) as! Exclusions
        var orderedSet  = [Exclusion]()
        for exclusionModel in exclusionList.exclusionList {
            let exclusion  = insertEntity(entityName: Constant.K_Entity.k_exclusion) as! Exclusion
            updateExclusion(exclusionModel: exclusionModel, exclusion: exclusion)
            orderedSet.append(exclusion)
        }
        exclusions.exclusion = NSOrderedSet(array: orderedSet)
        saveContext()
        return exclusions
    }

    private func updateExclusion(exclusionModel : ExclusionModel, exclusion : Exclusion){
        exclusion.facilityID  = exclusionModel.facilityID
        exclusion.optionId    = exclusionModel.optionID
        saveContext()
    }

    /// Make Entity by passing entity name
    private func insertEntity(entityName : String) -> AnyObject {
        let viewContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName:entityName, in: viewContext)
        let entityObj = NSManagedObject(entity: entity!, insertInto: viewContext)
        return entityObj
    }

    // MARK: - Core Data Saving support
    func saveContext () {
        if Thread.isMainThread == true  {
            saveDbChanges()
        } else{
            DispatchQueue.main.sync {
                saveDbChanges()
            }
        }
    }

    private func saveDbChanges() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

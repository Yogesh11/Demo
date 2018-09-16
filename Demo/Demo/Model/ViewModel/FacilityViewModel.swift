//
//  FacilityViewModel.swift
//  Demo
//
//  Created by Yogesh on 8/28/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class FacilityViewModel: BaseViewModel {
    var facilityStorage = [Facility]()
    var exclusionStorage = [Exclusions]()

    func fetchData(completionBlock : @escaping Constant.k_CompletionBlock) {
        ApiManager.sharedManager.getData { (json, error) in
            if let responseJson = json {
                if let facilityArray = responseJson[Constant.K_jsonKeys.k_Facility] as? [[String : AnyObject]] {
                    self.facilityStorage.removeAll()
                    for dict in facilityArray {
                        let facilityModel = FacilityModel()
                        facilityModel.prepareModel(json: dict)
                        self.facilityStorage.append(DataBaseManager.sharedManager.saveFacility(facilityModel: facilityModel))
                    }

                    if let exclusionArray = responseJson[Constant.K_jsonKeys.k_ExclusionList] as? [[[String : Any]]] {
                        self.exclusionStorage.removeAll()
                        for dict in exclusionArray {
                            let exclusionList = ExclusionList()
                            exclusionList.prepareModel(json: dict)
                            self.exclusionStorage.append( DataBaseManager.sharedManager.saveExclustion(exclusionList: exclusionList))
                        }
                    }
                    UserDefaults.standard.setValue(Date(), forKey: Constant.K_UserDefaultKey.k_LastSyncDate)
                    UserDefaults.standard.synchronize()
                    completionBlock("" as AnyObject , nil)
                } else{
                    completionBlock(nil , RError())
                }
            }
        }

    }

    func getData(completionBlock : @escaping Constant.k_CompletionBlock) {
        if let lastSyncDate = UserDefaults.standard.value(forKey: Constant.K_UserDefaultKey.k_LastSyncDate) as? Date {
            let currentDate  = Date()
            let calendar = NSCalendar.current
            let date1 = calendar.startOfDay(for: lastSyncDate)
            let date2 = calendar.startOfDay(for: currentDate)
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            if let day  = components.day , day >= 1{
                facilityStorage = DataBaseManager.sharedManager.getAllFacility() ?? []
                fetchData(completionBlock: completionBlock)
            } else{
                facilityStorage = DataBaseManager.sharedManager.getAllFacility() ?? []
                completionBlock("" as AnyObject , nil)
            }
        } else{
            fetchData(completionBlock: completionBlock)
        }
    }
}

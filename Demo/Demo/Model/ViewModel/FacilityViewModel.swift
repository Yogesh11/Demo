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

    func getData(completionBlock : @escaping Constant.k_CompletionBlock) {
        facilityStorage = DataBaseManager.sharedManager.getAllFacility() ?? []
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
                    completionBlock("" as AnyObject , nil)
                } else{
                    completionBlock(nil , RError())
                }
            }
        }
    }


    func selectedAnswer(facilityModel : FacilityModel , optionModel : OptionModel) {
//        if let answer = facilityModel.selectedOption {
//            reset(facilityID: facilityModel.id, optionID: answer.id)
//        }
//        facilityModel.selectedOption = optionModel
//        for exclusion in exclusionStorage {
//            exclusion.checkForAnswer(facilityID: facilityModel.id, optionID: optionModel.id)
//        }
    }

    func reset(facilityID : String , optionID : String) {
//        for exclusion in exclusionStorage {
//            if let exclusionList = exclusion.reset(facilityID: facilityID, optionID: optionID) {
//                for exclusionModel in exclusionList {
//
//                }
//            }
//        }
    }


}

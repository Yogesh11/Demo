//
//  ExclusionList.swift
//  Demo
//
//  Created by Yogesh on  9/16/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class ExclusionList: NSObject {
    var exclusionList =  [ExclusionModel]()
    func prepareModel(json : [[String : Any]]) {
        for dict in  json {
            let exclusion = ExclusionModel()
            exclusion.prepareModel(json: dict as! [String : String])
            exclusionList.append(exclusion)
        }
    }

    func reset(facilityID : String , optionID : String)->ExclusionModel?{
        for exclusion in exclusionList {
            if exclusion.facilityID == facilityID &&  exclusion.optionID == optionID{
                return exclusion
            }
        }
        return nil
    }

    func checkForAnswer(facilityID : String , optionID : String) -> Bool {
        for exclusion in exclusionList {
            if exclusion.facilityID == facilityID &&  exclusion.optionID == optionID{
                return true
            }
        }
        return false
    }
}

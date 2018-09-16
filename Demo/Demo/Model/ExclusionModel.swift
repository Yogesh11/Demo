//
//  Exclusion.swift
//  Demo
//
//  Created by Yogesh on 9/16/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class ExclusionModel: NSObject {
     var facilityID  :String! = ""
     var optionID    :String! = ""

     func prepareModel(json : [String : String]) {
        facilityID = json[Constant.K_jsonKeys.k_Facility_id]
        optionID   = json[Constant.K_jsonKeys.k_options_id]
     }
}

//
//  FacilityModel.swift
//  Demo
//
//  Created by Yogesh on 8/28/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class FacilityModel: BaseModel {
    var options = [OptionModel]()
    var name  : String? = nil
    override func prepareModel(json : Dictionary<String, Any>?) {
        super.prepareModel(json: json)
        name  = json?[Constant.K_jsonKeys.k_Name] as? String
        id    = json?[Constant.K_jsonKeys.k_Facility_id] as? String ?? ""
        if let optionJson = json?[Constant.K_jsonKeys.k_Option] as? [Dictionary<String, Any>] {
            for opt in optionJson{
                let option = OptionModel()
                option.prepareModel(json: opt)
                options.append(option)
            }
        }
    }

    

}

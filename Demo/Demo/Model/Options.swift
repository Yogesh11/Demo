//
//  Option.swift
//  Demo
//
//  Created by Yogesh on 8/28/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class OptionModel: BaseModel {
    var name : String?  = nil
    var icon : String?  = nil
    
    override func prepareModel(json : Dictionary<String, Any>?) {
        super.prepareModel(json: json)
        id    = json?[Constant.K_jsonKeys.k_id] as? String ?? ""
        name  = json?[Constant.K_jsonKeys.k_Name] as? String ?? ""
        icon  = json?[Constant.K_jsonKeys.k_icon] as? String ?? ""
    }
}

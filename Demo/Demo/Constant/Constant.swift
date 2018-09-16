//
//  Constant.swift
//  Demo
//
//  Created by Yogesh on 8/28/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

struct Constant {
    struct K_jsonKeys {
        static let k_Facility_id              = "facility_id"
        static let k_Name                     = "name"
        static let k_Option                   = "options"
        static let k_icon                     = "icon"
        static let k_id                       = "id"
        static let k_options_id               = "options_id"
        static let k_Facility                 = "facilities"
        static let k_ExclusionList            = "exclusions"
    }

    struct K_Entity {
        static let k_Facility              = "Facility"
        static let k_Option                = "Option"
        static let k_exclusions            = "Exclusions"
        static let k_exclusion             = "Exclusion"
    }

     static let k_EndUrl                = "https://my-json-server.typicode.com/iranjith4/ad-assignment/db"
     typealias k_CompletionBlock        = (_ result: AnyObject?   , _ error: RError?) -> Void
}

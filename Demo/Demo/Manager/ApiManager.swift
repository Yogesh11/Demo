//
//  ApiManager.swift
//  Demo
//
//  Created by Yogesh on 8/28/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class ApiManager: NSObject {
     static let sharedManager  = ApiManager()
    private lazy var sessionManager: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.urlCache = nil
        /*The timeout interval to use when waiting for additional data. The timer associated with this value is reset whenever new data arrives. When the request timer reaches the specified interval without receiving any new data, it triggers a timeout.*/
        sessionConfig.timeoutIntervalForRequest = TimeInterval(120.0)
        /*The maximum amount of time that a resource request should be allowed to take. This value controls how long to wait for an entire resource to transfer before giving up. The resource timer starts when the request is initiated and counts until either the request completes or this timeout interval is reached, whichever comes first.*/
        sessionConfig.timeoutIntervalForResource = TimeInterval(120.0)
        return  URLSession(configuration: sessionConfig) //URLSessionConfiguration.default
    }()

    func getData(completionBlock : @escaping Constant.k_CompletionBlock) {
        sessionManager.dataTask(with: URL(string: Constant.k_EndUrl)!) { (data, response, error) in
            guard let data  = data , error == nil else {
                if let errorObj = error as NSError?  {
                    completionBlock(nil , RError(errorMessage: errorObj.localizedDescription, errorCode: String(errorObj.code)))
                }
                else{
                     completionBlock(nil , RError())
                }
                return
            }
            do {
                if let json =  try JSONSerialization.jsonObject(with: data) as? [String : AnyObject] {
                    completionBlock(json as AnyObject ,nil)
                } else{
                    completionBlock(nil , RError())
                }

            } catch {
                completionBlock(nil , RError())
            }
        }.resume()
    }
}

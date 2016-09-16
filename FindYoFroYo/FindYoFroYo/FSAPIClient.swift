//
//  FSAPIClient.swift
//  FindYoFroYo
//
//  Created by Elli Scharlin on 9/16/16.
//  Copyright © 2016 ElliScharlin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

struct FoursquareConstants {
    static let v = "20160808"
    static let query = "Frozen Yogurt"
}


class FSAPIClient {
    
    class func getQueryForSearchLandmarks(parameter: [String: String], completion: (JSON?, ErrorType?) -> ()) {
        
        Alamofire.request(.GET, FoursquareKeys.getVenue, parameters: parameter, headers: nil).responseJSON { response in
            guard let data = response.data, responseJSON = JSON(data: data).dictionary?["response"] else {
                completion(nil,response.result.error)
                return
            }
            completion(responseJSON, nil)
        }
    }
}

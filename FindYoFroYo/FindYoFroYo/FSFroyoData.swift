//
//  FSFroyoData.swift
//  FindYoFroYo
//
//  Created by Elli Scharlin on 9/16/16.
//  Copyright © 2016 ElliScharlin. All rights reserved.
//

import Foundation
import SwiftyJSON

class FSFroyoData: NSObject {
    
    var placeIdentifier: String
    var placeVenue: [String : JSON]
    var placeLongitude: Double
    var placeLatitude: Double
    var placeName: String
    var placeAddress: String
    var placePhotoURL: String
    
    init(json: JSON) {
        guard let
            venue = json.dictionary,
            identifier = venue["id"]!.string,
            longitude = venue["location"]!["lng"].double,
            latitude = venue["location"]!["lat"].double,
            address = venue["location"]!["formattedAddress"].array,
            name = venue["name"]!.string
            
            else {
                fatalError("There was an error retrieving the information from FourSquare")
        }
        
        var addressStringConverter = ""
        
        for i in 0..<address.count {
            addressStringConverter.appendContentsOf(address[i].stringValue)
        }
        
        placeVenue = venue
        placeLatitude = (latitude)
        placeLongitude = (longitude)
        placeName = name
        placeAddress = addressStringConverter
        placeIdentifier = identifier
        placePhotoURL = FoursquareKeys.getPhoto.stringByReplacingOccurrencesOfString("%@", withString: placeIdentifier)
    }
}

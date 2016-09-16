//
//  FSDataStore.swift
//  FindYoFroYo
//
//  Created by Elli Scharlin on 9/16/16.
//  Copyright © 2016 ElliScharlin. All rights reserved.

import CoreLocation

class FSDataStore {
    
    var origin: CLLocation
    var destination: CLLocation
    var foursquareData: Set<FSFroyoData> = []
    
    init(origin: CLLocation, destination: CLLocation) {
        self.origin = origin
        self.destination = destination
    }
    
    func fetchLocationsFromFoursquareWithCompletion(centerPoint: CLLocation, completion: Bool -> ()) {
        let parameter = ["client_id": FoursquareKeys.clientId,
                         "client_secret": FoursquareKeys.clientSecret,
                         "v": "20160826",
                         "intent": "browse",
                         "ll": "\(centerPoint.coordinate.latitude), \(centerPoint.coordinate.longitude)",
                         "categoryId": FoursquareKeys.froyoID]
        
        FSAPIClient.getQueryForSearchLandmarks(parameter) { itemsJSON in
            guard let itemsArray = itemsJSON.0?.dictionary!["venues"]?.array else {
                print("error: no data recieved from API Client")
                completion(false)
                return
            }
            
            for venue in itemsArray {
                self.FSFroyoData.insert(FoursquareData(json: venue))
            }
            completion(true)
        }
    }
}
//    
//    var totalDistance: Double {
//        return origin.distanceFromLocation(destination)
//    }
//    
//    var searchRadius: Double {
//        return totalDistance/2
//    }
//    
//    func midpointCoordinates() -> CLLocation {
//        let centerLatitidue = (origin.coordinate.latitude + destination.coordinate.latitude) / 2
//        let centerLongitude = (origin.coordinate.longitude + destination.coordinate.longitude) / 2
//        return CLLocation(latitude: centerLatitidue, longitude: centerLongitude)
//    }
//    
//}
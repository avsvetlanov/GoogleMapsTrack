//
//  TrackPoint.swift
//  GoogleMapsTrack
//
//  Created by  Svetlanov on 23.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class TrackPoint {
    var lat : Double = 0
    var lng : Double = 0
    var date : Int = 0
    var speed : Int = 0
    
    func parseDict(dict: NSDictionary, completion: CompletionSuccessStatus) {
        if let lat = dict.objectForKey("lat") as? Double,
            let lng = dict.objectForKey("lng") as? Double,
            let date = dict.objectForKey("date") as? Int,
            let speed = dict.objectForKey("speed") as? Int {
            self.lat = lat
            self.lng = lng
            self.date = date
            self.speed = speed
            
            completion(success: true, error: nil)
        } else {
            completion(success: false, error: "Track point parse error. Dict: \(dict)")
        }
    }
    
    func toString() -> String {
        return "Track={"
            + "lat:\(lat),"
            + "lng:\(lng),"
            + "date:\(date),"
            + "speed:\(speed)"
            + "}"
    }
}
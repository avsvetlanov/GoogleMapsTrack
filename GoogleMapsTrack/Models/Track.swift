//
//  Track.swift
//  GoogleMapsTrack
//
//  Created by  Svetlanov on 23.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class Track {
    var start : Int = 0
    var end : Int = 0
    var length : Int = 0
    var count : Int = 0
    var maxSpeed : Int = 0
    var points : [TrackPoint] = []
    
    func parseDict(dict: NSDictionary, completion: CompletionSuccessStatus) {
        if let startString = dict.objectForKey("start") as? String,
            let startInt = Int(startString),
            
            let endString = dict.objectForKey("end") as? String,
            let endInt = Int(endString),
            
            let lengthString = dict.objectForKey("length") as? String,
            let lengthInt = Int(lengthString),
            
            let countString = dict.objectForKey("count") as? String,
            let countInt = Int(countString),
            
            let maxSpeedString = dict.objectForKey("max_speed") as? String,
            let maxSpeedInt = Int(maxSpeedString),
            
            let pointDictionaryArray = dict.objectForKey("points") as? [NSDictionary]
        
        {
            
            self.start = startInt
            self.end = endInt
            self.length = lengthInt
            self.count = countInt
            self.maxSpeed = maxSpeedInt
            
            self.points = []
            for pointDictionary in pointDictionaryArray {
                let point = TrackPoint()
                point.parseDict(pointDictionary, completion: { (success, error) in
                    if success {
                        self.points.append(point)
                    } else {
                        Log.e(error)
                    }
                })
            }
            
            completion(success: true, error: nil)
        } else {
            completion(success: false, error: "Track parse error. Dict: \(dict)")
        }
    }
    
    func toString() -> String {
        var result = "Track={"
        result +=  "start:\(start),"
        result +=  "end:\(end),"
        result +=  "length:\(length),"
        result +=  "count:\(count),"
        result +=  "maxSpeed:\(maxSpeed),"
        result +=  "points:["
        for point in points {
            result += point.toString() + ","
        }
        return result + "]}"
    }
}
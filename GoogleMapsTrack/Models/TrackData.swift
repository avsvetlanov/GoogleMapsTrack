//
//  TrackData.swift
//  GoogleMapsTrack
//
//  Created by  Svetlanov on 23.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class TrackData {
    
    var state : String? = ""
    var msg : String? = ""
    var data : Track = Track()
    
    func parseDict(dict: NSDictionary, completion: CompletionSuccessStatus) {
        self.state = dict.objectForKey("state") as? String
        self.msg = dict.objectForKey("msg") as? String
        
        if let trackDictionary = dict.objectForKey("data") as? [NSDictionary] {
            self.data.parseDict(trackDictionary[0], completion: { (success, error) in
                if success {
                    completion(success: true, error: nil)
                } else {
                    completion(success: false, error: "Could not parse track. State = \(self.state), msg = \(self.msg)")
                }
            })
        }
    }
    
    func toString() -> String {
        return "TrackContainer={"
            + "state:\(state),"
            + "msg:\(msg),"
            + "data:\(data.toString())"
    }
}
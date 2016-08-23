//
//  TrackController.swift
//  GoogleMapsTrack
//
//  Created by  Svetlanov on 23.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class TrackController {
    
    var track : Track?
    
    let trackFileName = "track.json"
    
    func loadTrackData(completion: CompletionSuccessStatus) {
        let data = FilesUtils.readJsonDictionaryFromFile(trackFileName)
        if data == nil {
            completion(success: false, error: "Error reading track from file")
            return
        }
        
        let trackData = TrackData()
        trackData.parseDict(data!) { (success, error) in
            if success {
                self.track = trackData.data
                completion(success: true, error: nil)
            } else {
                completion(success: false, error: error)
            }
        }
    }
    
    func getTrackInfo() -> String {
        if track == nil {
            return "Error: the track information was not loaded"
        }
        
        var info = String(format: "Length: %.1f \n", Double(track!.length) / 1000)
        info += "Max speed: \(track!.maxSpeed)\n"
        
        let startedDate = NSDate(timeIntervalSince1970: NSTimeInterval(track!.start))
        let endedDate = NSDate(timeIntervalSince1970: NSTimeInterval(track!.end))
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy: HH:mm"
        var formatedDate = dateFormatter.stringFromDate(startedDate)
        dateFormatter.dateFormat = "-HH:mm"
        formatedDate += dateFormatter.stringFromDate(endedDate)
        
        info += "Time: \(formatedDate)"
        
        return info
    }
    
    private func loadTrackFromFile() {
        
    }
}
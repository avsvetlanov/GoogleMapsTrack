//
//  Log.swift
//  GoogleMapsTrack
//
//  Created by  Svetlanov on 23.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation

class Log {
    class func d(logMessage: AnyObject?, fileName: String = #file, lineNumber: Int = #line, functionName: String = #function) {
        print("[Debug] \(NSURL(fileURLWithPath: fileName).lastPathComponent!)|\(functionName)(\(lineNumber)): \(String(logMessage))")
    }
    class func e(logMessage: AnyObject?, fileName: String = #file, lineNumber: Int = #line, functionName: String = #function) {
        print("[ERROR] \(NSURL(fileURLWithPath: fileName).lastPathComponent!)|\(functionName)(\(lineNumber)): \(String(logMessage))")
    }
}
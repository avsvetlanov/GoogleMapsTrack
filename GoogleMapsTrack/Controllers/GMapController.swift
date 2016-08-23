//
//  GMapController.swift
//  sberbank.test
//
//  Created by  Svetlanov on 23.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import Foundation
import GoogleMaps

class GMapController {
    
    static let MAX_SPEED_ONE = 60
    static let MAX_SPEED_TWO = 120
    // MAX_SPEED_THREE is infinity
    
    static let COLOR_SPEED_ONE = UIColor.greenColor()
    static let COLOR_SPEED_TWO = UIColor.yellowColor()
    static let COLOR_SPEED_THREE = UIColor.redColor()
    
    
    
    static let ZOOM_LEVEL_ONE : Float = 14
    static let ZOOM_LEVEL_TWO : Float = 10
    
    static let POLYLINE_WIDTH_LEVEL_ONE : CGFloat = 4.0
    static let POLYLINE_WIDTH_LEVEL_TWO : CGFloat = 6.0
    static let POLYLINE_WIDTH_LEVEL_DEFAULT : CGFloat = 10.0
    
    class func getPolylinesWithSpeedColors(points: [TrackPoint]) -> [GMSPolyline] {
        
        guard points.count >= 2 else {
            Log.e("Could not build the route in less than a two point")
            return []
        }
        
        var polylines = [GMSPolyline]()
        
        var previousCoordinate = CLLocationCoordinate2D(latitude: points.first!.lat, longitude: points.first!.lng)
        for i in 1...points.count-1 {
            let path = GMSMutablePath()
            let currentCoordinate = CLLocationCoordinate2D(latitude: points[i].lat, longitude: points[i].lng)
            path.addCoordinate(previousCoordinate)
            path.addLatitude(points[i].lat, longitude: points[i].lng)
            
            previousCoordinate = currentCoordinate
            
            let polyline = GMSPolyline(path: path)
            if points[i].speed <= MAX_SPEED_ONE {
                polyline.strokeColor = COLOR_SPEED_ONE
            } else if points[i].speed <= MAX_SPEED_TWO {
                polyline.strokeColor = COLOR_SPEED_TWO
            } else {
                polyline.strokeColor = COLOR_SPEED_THREE
            }
            
            polylines.append(polyline)
        }
        
        return polylines
    }
    
    class func getCameraWithPolylinesBounds(polylines: [GMSPolyline]) -> GMSCameraUpdate {
        var bounds = GMSCoordinateBounds()
        for polyline in polylines {
            bounds = bounds.includingPath(polyline.path!)
        }
        
        return GMSCameraUpdate.fitBounds(bounds)
    }
    
    class func removePolylinesFromMap(polylines: [GMSPolyline]) {
        for polyline in polylines {
            polyline.map = nil
        }
    }
    
    class func addPolylinesToMap(polylines: [GMSPolyline], mapView: GMSMapView) {
        for polyline in polylines {
            polyline.map = mapView
        }
    }
    
    class func getPolylinesWidthForZoom(zoom: Float) -> CGFloat {
        if zoom >= ZOOM_LEVEL_ONE {
            return POLYLINE_WIDTH_LEVEL_ONE
        } else if zoom >= ZOOM_LEVEL_TWO {
            return POLYLINE_WIDTH_LEVEL_TWO
        } else {
            return POLYLINE_WIDTH_LEVEL_DEFAULT
        }
    }
    
    class func updatePolylinesWidth(polylines: [GMSPolyline], width: CGFloat) {
        for polyline in polylines {
            polyline.strokeWidth = width
        }
    }
}
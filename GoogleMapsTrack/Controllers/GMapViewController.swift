//
//  GMapViewController.swift
//  GoogleMapsTrack
//
//  Created by  Svetlanov on 23.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import UIKit
import GoogleMaps

class GMapViewController: GMSMapView, GMSMapViewDelegate {
    
    var points : [TrackPoint] = []
    private var routePolylines : [GMSPolyline] = []
    private var currentRouteWidth : CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
    }
    
    func showTrackPointsRoute() {
        GMapController.removePolylinesFromMap(routePolylines)
        
        routePolylines = GMapController.getPolylinesWithSpeedColors(points)
        GMapController.addPolylinesToMap(routePolylines, mapView: self)
    }
    
    func moveCameraToRoute() {
        let routeCamera = GMapController.getCameraWithPolylinesBounds(routePolylines)
        self.moveCamera(routeCamera)
        updateRouteWidth()
    }
    
    func updateRouteWidth() {
        let newRouteWidth = GMapController.getPolylinesWidthForZoom(self.camera.zoom)
        if newRouteWidth != currentRouteWidth {
            GMapController.updatePolylinesWidth(routePolylines, width: newRouteWidth)
            currentRouteWidth = newRouteWidth
        }
    }
    
    /* GMSMapViewDelegate */
    
    func mapView(mapView: GMSMapView, didChangeCameraPosition position: GMSCameraPosition) {
        updateRouteWidth()
    }
}
//
//  ViewController.swift
//  GoogleMapsTrack
//
//  Created by  Svetlanov on 23.08.16.
//  Copyright © 2016  Svetlanov. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMapViewController!
    
    private var trackController = TrackController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //todo: load track from http ???

    //todo: change dates of files
    //todo: check folders in finder
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        loadTrackFromFile(withAlert: true)
        showTrackOnMap()
        
        self.navigationItem.title = "Track"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(ViewController.showAlertWithTrackInfo))
    }

    func loadTrackFromFile(withAlert showAlert: Bool) {
        var alert : UIAlertController?
        
        if showAlert {
            alert = UIAlertController(title: "Please, wait", message: "Loading track", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(alert!, animated: true, completion: nil)
        }
        
        trackController.loadTrackData { (success, error) in
            if success {
                alert?.dismissViewControllerAnimated(true, completion: nil)
            } else {
                alert?.message = error
                alert?.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            }
        }
    }
    
    func showTrackOnMap() {
        if let points = trackController.track?.points {
            self.mapView.points = points
            self.mapView.showTrackPointsRoute()
            self.mapView.moveCameraToRoute()
        }
    }
    
    func showAlertWithTrackInfo() {
        let trackInfo = trackController.getTrackInfo()
        
        let alert = UIAlertController(title: "Information about track", message: trackInfo, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}


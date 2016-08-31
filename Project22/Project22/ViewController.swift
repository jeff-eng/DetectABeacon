//
//  ViewController.swift
//  Project22
//
//  Created by Jeffrey Eng on 8/30/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var distanceReading: UILabel!

    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create location manager object
        locationManager = CLLocationManager()
        // Set ourselves as the delegate
        locationManager.delegate = self
        // Request authorization
        locationManager.requestWhenInUseAuthorization()
        
        //Change background color to gray
        view.backgroundColor = UIColor.grayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // checks if user authorized use of their location when using app
        if status == .AuthorizedWhenInUse {
            // Here it checks if device is able to monitor iBeacons
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                // Checks if ranging(ability to tell how far something else is away from device) is available
                if CLLocationManager.isRangingAvailable() {
                    // do stuff here in this code block
                }
            }
        }
    }

}


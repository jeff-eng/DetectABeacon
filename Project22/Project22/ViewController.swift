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

    func startScanning() {
        // create a unique identifier string
        let uuid = NSUUID(UUIDString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")
        // uniquely identify beacon and pass major & minor numbers into CLBeaconRegion class
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: 123, minor: 456, identifier: "MyBeacon")
        
        // beacon region gets passed into location manager to monitor for existence of region
        locationManager.startMonitoringForRegion(beaconRegion)
        // beacon region gets passed into location manager to start measuring distance between iDevice and beacon
        locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
}


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
                // Only start scanning for beacons when we have permission and if device is able to do so
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
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
    
    // Method to change the label's text and color depending on proximity from beacon. The cases within Switch statement come from the CLProximity class which has an enum with those cases
    func updateDistance(distance: CLProximity) {
        UIView.animateWithDuration(0.8) { [unowned self] in
            switch distance {
            case .Unknown:
                // set background color to gray
                self.view.backgroundColor = UIColor.grayColor()
                // set text to "UNKNOWN"
                self.distanceReading.text = "UNKNOWN"
                
            case .Far:
                // set background color to blue
                self.view.backgroundColor = UIColor.blueColor()
                // set text to "FAR"
                self.distanceReading.text = "FAR"
                
            case .Near:
                // set background color to orange
                self.view.backgroundColor = UIColor.orangeColor()
                // set text to "NEAR"
                self.distanceReading.text = "NEAR"
                
            case .Immediate:
                // set background color to red
                self.view.backgroundColor = UIColor.redColor()
                // set text to "RIGHT HERE"
                self.distanceReading.text = "RIGHT HERE"
                
            }
        }
    }
    
    // If we receive any beacons from location manager, take the first one and use its proximity property and pass it to updateDistance to update the app UI, otherwise use 'unknown'
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if beacons.count > 0 {
            let beacon = beacons[0]
            updateDistance(beacon.proximity)
        } else {
            updateDistance(.Unknown)
        }
    }
}


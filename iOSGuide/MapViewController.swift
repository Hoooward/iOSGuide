//
//  MapViewController.swift
//  iOSGuide
//
//  Created by Howard on 3/7/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // Properties
    var mapView: MKMapView!
    var locationManager: CLLocationManager?
    
    // MARK: - View Lift cycle
    
    /*
        When the view controller is asked for its view and its
        view its nil, then loadView() method is called.
    */
    override func loadView() {
        mapView = MKMapView()
        
      
        //Set it as *the* view of this view controller
        mapView.delegate = self
        view = mapView
        
        let segementedOne = NSLocalizedString("Standard", comment: "one")
        let segementedTwo = NSLocalizedString("Hybrid", comment: "two")
        let segementedThree = NSLocalizedString("Statellite", comment: "three")
        
        
        let segmentedControl = UISegmentedControl(items: [segementedOne , segementedTwo, segementedThree])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.addTarget(self, action: "mapTypeChanged:", forControlEvents: .ValueChanged)
        
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
//        let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(view.layoutMarginsGuide.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(view.layoutMarginsGuide.trailingAnchor)
        
        NSLayoutConstraint(
            item: segmentedControl,
            attribute: .Leading,
            relatedBy: .Equal,
            toItem: view,
            attribute: .LeadingMargin,
            multiplier: 1.0,
            constant: 0.0).active = true
        
        topConstraint.active = true
//        leadingConstraint.active = true
        trailingConstraint.active = true
        
        let locationButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        locationButton.setTitle("定位", forState: .Normal)
        locationButton.setImage(UIImage(named: "MapIcon"), forState: .Normal)
        
//        let attributeds = NSAttributedString(string: "定位", attributes: [NSFontAttributeName: UIFont(name: "Chalkduster", size: 100)!])
//        locationButton.setAttributedTitle(attributeds, forState: .Normal)
        locationButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        locationButton.setTitleColor(UIColor.yellowColor(), forState: .Highlighted)
        locationButton.addTarget(self, action: "showMyLocation:", forControlEvents: .TouchUpInside)
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(locationButton)
        
        
        let margin = view.layoutMarginsGuide
        
        let bottomConstarint = locationButton.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor, constant: 0)
        let leadingConstraint = locationButton.leadingAnchor.constraintEqualToAnchor(margin.leadingAnchor, constant: 0)
        
        NSLayoutConstraint(item: locationButton, attribute: .Width, relatedBy: .Equal, toItem: locationButton, attribute: .Height, multiplier: 1.0, constant: 0.0).active = true
        
        bottomConstarint.active = true
        leadingConstraint.active = true
        
    }
    
    // Map view delegate
    func mapViewWillStartLoadingMap(mapView: MKMapView) {
        
    }
    
    // Location button funcation with show my location
    func showMyLocation(sender: UIButton) {
        
       
        if  CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager = CLLocationManager()
            print ("bing!")
            locationManager!.requestWhenInUseAuthorization()
        }
        

//        CLLocationManager().requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        
        
    }
    
    // Segmented control funcation with value changed.
    func mapTypeChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default: break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var randomNumber: CGFloat {
        
        return CGFloat(arc4random_uniform(255))
    }
    
    var randomColor: UIColor {
        return UIColor(red: randomNumber/255, green: randomNumber/255, blue: randomNumber/255, alpha: 1)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = randomColor
        print ("\(randomNumber)")
        
    }
}

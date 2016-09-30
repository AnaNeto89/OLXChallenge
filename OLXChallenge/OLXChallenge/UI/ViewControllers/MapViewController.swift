//
//  MapViewController.swift
//  OLXChallenge
//
//  Created by Ana Neto on 30/09/16.
//  Copyright © 2016 Ana Neto. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    //MARK: Variables
    private var locationManager:CLLocationManager?
    var location:CLLocation?
    var adLatitude:Double?
    var adLongitude:Double?
    var adTitle:String?
    var zoom:Int?
    
    //MARK: IBOutlets
    @IBOutlet var mapView: MKMapView!
    
    //MARK: lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapConfigurations()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //if coordinates are defined
        if self.adLatitude != nil && self.adLongitude != nil {
            //then
            buildAndAddAnnotationToMap()
            locationConfigurations()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: auxiliar methods
    
    func mapConfigurations(){
        
        self.mapView.zoomEnabled = true
        self.mapView.delegate = self
    }
    
    func locationConfigurations(){
        self.locationManager = CLLocationManager()
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager!.requestAlwaysAuthorization()
        self.mapView.showsUserLocation = true
    }
    
    func setZoom(){
        let distance = self.mapView.userLocation.location!.distanceFromLocation(self.location!)
        
        // magic number 50 : to draw a region to include the poi , and to see better the poi i added a 50 margin
        let region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.location!.coordinate, distance*2+50, distance*2+50)
        
        self.mapView.setRegion(region, animated: true)
        
    }
    
    func buildAndAddAnnotationToMap() {
        self.location = CLLocation(latitude: CLLocationDegrees(self.adLatitude!), longitude: CLLocationDegrees(self.adLongitude!))
        
        var pin:MKPointAnnotation? = nil
        
        pin = MKPointAnnotation()
        pin!.coordinate = self.location!.coordinate
        pin!.title = self.title
        
        self.mapView.addAnnotation(pin!)
    }
}

extension MapViewController:MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        self.setZoom()
    }
}


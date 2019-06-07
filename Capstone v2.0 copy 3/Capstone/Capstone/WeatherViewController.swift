//
//  WeatherViewController.swift
//  Capstone
//
//  Created by Danielle Alloy on 5/8/19.
//  Copyright © 2019 Danielle Alloy. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    var myWeather = WeatherModelCollection()
    let locationManager = CLLocationManager()



    @IBOutlet weak var weatherTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myWeather.getWeather()
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
        }

        
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        //map.mapType = MKMapType.standard
        
        //let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        //let region = MKCoordinateRegion(center: locValue, span: span)
        //map.setRegion(region, animated: true)
        
        //let annotation = MKPointAnnotation()
        //annotation.coordinate = locValue
        //annotation.title = "You are Here"
        //map.addAnnotation(annotation)
        print("lattitude \(locValue.latitude)")
        
        //centerMap(locValue)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

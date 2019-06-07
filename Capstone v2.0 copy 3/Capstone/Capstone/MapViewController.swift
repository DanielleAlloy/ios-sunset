//
//  MapViewController.swift
//  Capstone
//
//  Created by Danielle Alloy on 5/8/19.
//  Copyright © 2019 Danielle Alloy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
     var mySunset = GoldenModelCollection()
    var myWeek = WeatherModelCollection()
    //var mySunset :GoldenModelCollection
    //var anotherSunset = GoldenModel()
    var myMap = Map()

    var count:Int = 0
    

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var GoldenHouStartText: UITextField!
    @IBOutlet weak var SunsetStarts: UITextField!
    @IBOutlet weak var moonPhase: UITextField!
    @IBOutlet weak var moonRiseText: UITextField!
    
    @IBOutlet weak var moonPhoneImage: UIImageView!
    //let locationManager = CLLocationManager()
   // var locationManager: CLLocationManager!
    let locationManager = CLLocationManager()


    @IBOutlet weak var weekdayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var sunsetArray = Array<GoldenModel>()
        var theUrl:URL = mySunset.makeUrl()
        
        //sunsetArray = mySunset.getSunset()
        myWeek.getWeather()

        mySunset.getSunset()
        ///mySunset.thisSunset![0].sunrise
        sleep(3)
       //var thisGoldenHour = mySunset.thisSunset?.count
        //var thisGoldenHour = mySunset?.sunrise
        sunsetArray = mySunset.dataFromURL(myURL:theUrl)

       let thisGoldenHourText = mySunset.thisSunset![0].sunrise
       GoldenHouStartText.text = thisGoldenHourText
        SunsetStarts.text = mySunset.thisSunset![0].sunset
        moonRiseText.text = mySunset.thisSunset![0].moonRise
        moonPhase.text = mySunset.thisSunset![0].moonPhase
        
        //let theMoonPhaseIconName = mySunset.thisSunset![0].moonPhaseIconName
        
       
        //let theMoonPhaseIcon:UIImage = UIImage(named: "noun_Full Moon_87976.png", in: Bundle(identifier: "edu.farmingdale.Capstone"), compatibleWith: nil)!

       // UIImage(named:"noun_Full Moon_87976.png")!//= UIImage(named: "Full_Moon.png")
        
        //if (theMoonPhaseIconName == "cw_waxing_crescent"){
          //  theMoonPhaseIcon = UIImage(named:"Full_Moon.png")
       //     theMoonPhaseIcon = UIImage(named:"Full_Moon.png")
     //   }
        
 
        //var actualMoonPhaseIcon = mySunset.thisSunset![0].getMoonIcon(theMoonPhaseIconName: theMoonPhaseIcon!)
 

       // moonPhoneImage.image = theMoonPhaseIcon

      
       // let thePicture = mySunset.thisSunset?[0].sunrise
        //mySunset.thisSunset
        
        //print("FUUUUUUUUUUUCCCCCCCCK \(String(describing: thisGoldenHour))")
/*
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
 */
        //print("This is a sunset\(mySunset.getSunset())")
        //GoldenHouStartText.text = mySunset.getSunset()
        /*works
        if (CLLocationManager.locationServicesEnabled())
        {
            //myMap.locationManager(CLLocationManager, didUpdateLocations: [CLLocation])
            locationManager = CLLocationManager()
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }*/
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
        }
        
        map.delegate = self
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        
        if let coor = map.userLocation.location?.coordinate{
            map.setCenter(coor, animated: true)
            
        }
    }
    @IBAction func forward(_ sender: Any) {
        
        while (count <= 5 && count >= 0){
            count += 1
            weekdayLabel.text = myWeek.thisWeekWeather![count].weekday
            GoldenHouStartText.text = mySunset.thisSunset![count].sunrise
            SunsetStarts.text = mySunset.thisSunset![count].sunset
            moonRiseText.text = mySunset.thisSunset![count].moonRise
            moonPhase.text = mySunset.thisSunset![count].moonPhase
            

            break
            
        }
    }
    @IBAction func backward(_ sender: Any) {
       if (count > 0){

            while (count <= 6){
                count -= 1

        
                weekdayLabel.text = myWeek.thisWeekWeather![count].weekday
                GoldenHouStartText.text = mySunset.thisSunset![count].sunrise
                SunsetStarts.text = mySunset.thisSunset![count].sunset
                moonRiseText.text = mySunset.thisSunset![count].moonRise
                moonPhase.text = mySunset.thisSunset![count].moonPhase

              break
                
            }
        }
    }
    /*
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }*/
    /*works
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        
    }
*/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        map.mapType = MKMapType.standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "You are Here"
        map.addAnnotation(annotation)
        print("lattitude \(locValue.latitude)")
        
        //centerMap(locValue)
    }

    
    

        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//
//  GoldenModel.swift
//  Capstone
//
//  Created by Danielle Alloy on 5/8/19.
//  Copyright © 2019 Danielle Alloy. All rights reserved.
//

import Foundation
import MapKit

class GoldenModel{
    //var currentTime:Float
    //var goldenHourStarts:String
    //var goldenHourEnds:Float
    //var blueHourStarts:Float
    //var blueHourEnds:Float
    //var currentLocation:MKMapView
    var sunset:String
    var cityName:String
    var sunrise:String
    var moonPhase:String
    var moonRise:String
    var utcTime:String
    var moonPhaseIconName:String?
    var moonPhaseIcon:UIImage?


    
    
    init(sunset:String,
         cityName:String,
        sunrise:String,
        moonPhase:String,
        moonRise:String,
        utcTime:String,
        moonPhaseIconName:String?
        ){
        self.sunset = sunset // set the class value to the param value
        self.cityName = cityName
        self.sunrise = sunrise
        self.moonPhase = moonPhase
        self.moonRise = moonRise
        self.utcTime = utcTime
        self.moonPhaseIconName = moonPhaseIconName
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    func getMoonIcon (theMoonPhaseIconName:String)->UIImage{
        var theMoonPhaseIcon:UIImage? //= UIImage(named: "Full_Moon.png")

        if (theMoonPhaseIconName == "cw_waxing_crescent"){
            theMoonPhaseIcon = UIImage(named:"Full_Moon.png")
        }

        if (theMoonPhaseIconName == "cw_full_moon"){
            theMoonPhaseIcon = UIImage(named:"Full_Moon.png")
        }
        
        return theMoonPhaseIcon!
    }
    /*
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        
        print("lattitude: \(location.coordinate.latitude)")
        print("Longitude \( location.coordinate.longitude)")
    }*/
    
    }

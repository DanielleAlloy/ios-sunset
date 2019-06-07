//
//  MapModel.swift
//  Capstone
//
//  Created by Danielle Alloy on 5/10/19.
//  Copyright © 2019 Danielle Alloy. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class Map{
    

    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

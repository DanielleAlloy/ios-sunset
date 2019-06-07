//
//  GoldenHourViewController.swift
//  Capstone
//
//  Created by Danielle Alloy on 5/2/19.
//  Copyright © 2019 Danielle Alloy. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class GoldenHourViewController: UIViewController {
    var myModel  = GoldenModelCollection()
    let locationManager = CLLocationManager()


    @IBOutlet weak var hoursTillSunset: UILabel!

    @IBOutlet weak var moonRiseLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)


        locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
        }
        myModel.getSunset()

        sleep(3)
        hoursTillSunset.text = myModel.thisSunset![0].sunset
        moonRiseLabel.text = myModel.thisSunset![0].moonRise

        // Do any additional setup after loading the view.
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

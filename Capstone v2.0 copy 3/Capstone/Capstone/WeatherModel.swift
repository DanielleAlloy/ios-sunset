//
//  WeatherModel.swift
//  Capstone
//
//  Created by Danielle Alloy on 5/10/19.
//  Copyright © 2019 Danielle Alloy. All rights reserved.
//

import Foundation
import UIKit

class Weather{
    var description: String
    var skyDescription: String?
    var percipChance: String?
    var highTemperature: String
    var lowTemperature: String
    var windSpeed: String
    var windDesc: String
    var iconName: String
    var iconLink: URL
    var weekday: String
    var thumbnail: UIImage?
    //var highTemperatureFarenhright: String? = covertToFarienhright(lowTemperature: highTemperature)

    func covertToFahrenheit(temperature:String)->String{
        let tempDouble = Double(temperature)!
        let fahrenheitTemperature = tempDouble * 9 / 5 + 32
        let fahrenheitTemperatureString = String(format: "%.0f", fahrenheitTemperature)
     
        return fahrenheitTemperatureString
    }
    
    func covertToMPH(speed:String)->String{
        let speedDouble = Double(speed)!
        let mphSpeed = speedDouble  / 1.609
        let mphSpeedString = String(format: "%.0f", mphSpeed)
        
        return mphSpeedString
    }
    
    init(description: String,
         skyDescription: String?,
         percipChance: String?,
         highTemperature: String,
         lowTemperature: String,
         windSpeed: String,
         windDesc: String,
         iconName: String,
         iconLink: URL,
         weekday: String){
        self.description = description // set the class value to the param value
        self.skyDescription = skyDescription
        self.percipChance = percipChance
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
        self.windSpeed = windSpeed
        self.windDesc = windDesc
        self.iconName = iconName
        self.iconLink = iconLink
        self.weekday = weekday
    }
    
    func getThumbnail(completionHandler: (()->())? = nil)->UIImage? {
        // 1. if the thumbnail exists, return it.
        if thumbnail != nil {
            return thumbnail
        }
        // 2. if the thumbnail is blank
        //      (a) try to make a data task
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: iconLink) {
            (data, response, error) in
            //      (b) get the tn data,
            if let actualError = error {
                print("Got an error in \(#file), line \(#line)")
            } else if let actualResponse = response,
                let actualData = data,
                let actualImage = UIImage(data: actualData) {
                //      (c) create a UIImage,
                //      (d) set the TN
                self.thumbnail = actualImage
                //      (e) and call the CH
                // If there is a completionHandler, dispatch it to the main thread
                DispatchQueue.main.async {
                    completionHandler?()
                }
            }
        } // completionHandler end
        task.resume()
        return thumbnail
    }
    
    
}

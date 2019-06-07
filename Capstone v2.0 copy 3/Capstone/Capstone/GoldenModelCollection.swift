//
//  GoldenModelCollection.swift
//  Capstone
//
//  Created by Danielle Alloy on 5/8/19.
//  Copyright © 2019 Danielle Alloy. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit


class GoldenModelCollection{
    
    
   //var myModel = GoldenModel()
   public var thisSunset: Array<GoldenModel>?
    let locationManager = CLLocationManager()

    
    //let locationManager = CLLocationManager()

    
    
    private func generateURL()->URL {
        

        if  (locationManager.location?.coordinate != nil){
            
            let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
            
            let lattitude:String = String(locValue.latitude)
            let longitude:String = String(locValue.longitude)
           
            
            let baseURL = "https://weather.cit.api.here.com/weather/1.0/report.json?"
            var urlComponents = URLComponents(string: baseURL)!
            var queryItemArrays=Array<URLQueryItem>()
            queryItemArrays.append(URLQueryItem(name: "product", value:"forecast_astronomy"))
            queryItemArrays.append(URLQueryItem(name: "latitude", value:lattitude))
            queryItemArrays.append(URLQueryItem(name: "longitude", value:longitude))
            queryItemArrays.append(URLQueryItem(name: "oneobservation", value:"13.389"))
            queryItemArrays.append(URLQueryItem(name: "app_id", value: GlobalConstants.APIKey.appId))
            queryItemArrays.append(URLQueryItem(name: "app_code", value: GlobalConstants.APIKey.appCode))



            print(urlComponents.string!)


        
            queryItemArrays.append(URLQueryItem(name: "format", value: "json"))
            queryItemArrays.append(URLQueryItem(name: "nojsoncallback", value: "1"))
            queryItemArrays.append(URLQueryItem(name: "extras", value: "date_taken,url_h,url_t,descriptions"))
            queryItemArrays.append(URLQueryItem(name: "safe_search", value: "1"))
            //queryItemArrays.append(URLQueryItem(name: "api_key", value: GlobalConstants.APIKey.flickAPIKey))*/
            urlComponents.queryItems = queryItemArrays
            print(urlComponents.string!)
            return urlComponents.url!
            
        }else{
 
            let baseURL = "https://weather.cit.api.here.com/weather/1.0/report.json?"
            var urlComponents = URLComponents(string: baseURL)!
            var queryItemArrays=Array<URLQueryItem>()
            queryItemArrays.append(URLQueryItem(name: "product", value:"forecast_astronomy"))
            queryItemArrays.append(URLQueryItem(name: "latitude", value:"52.516"))
            queryItemArrays.append(URLQueryItem(name: "longitude", value:"13.389"))
            queryItemArrays.append(URLQueryItem(name: "oneobservation", value:"true"))
            queryItemArrays.append(URLQueryItem(name: "app_id", value: GlobalConstants.APIKey.appId))
            queryItemArrays.append(URLQueryItem(name: "app_code", value: GlobalConstants.APIKey.appCode))
            
            
            
            print(urlComponents.string!)
            
            
        
             queryItemArrays.append(URLQueryItem(name: "format", value: "json"))
             queryItemArrays.append(URLQueryItem(name: "nojsoncallback", value: "1"))
             queryItemArrays.append(URLQueryItem(name: "extras", value: "date_taken,url_h,url_t,descriptions"))
             queryItemArrays.append(URLQueryItem(name: "safe_search", value: "1"))
             //queryItemArrays.append(URLQueryItem(name: "api_key", value: GlobalConstants.APIKey.flickAPIKey))
            urlComponents.queryItems = queryItemArrays
            print(urlComponents.string!)
            return urlComponents.url!
       }
        
    }
    func dataFromURL(myURL: URL, completionHandler: (()->())? = nil)->Array<GoldenModel> {
        var mySunsetArray = Array<GoldenModel>()
        
        let session = URLSession(configuration: .ephemeral)
        
        let task = session.dataTask(with: myURL) {
            (data,response,error)->Void in
            var localSunsetArray = Array<GoldenModel>()
            if let actualError = error {
                print("Got an error-Error is \(actualError)")
            } else if let actualResponse = response,
                let actualData = data,
                let parsedData = try? JSON(data: actualData) {
                print("I got some data: \(actualData)")

                let theAstronomyData = parsedData["astronomy"]
                let theSunset = theAstronomyData["astronomy"]
                
                for (_, oneSunset) in theSunset {
                    print("I got a sunset: \(oneSunset)")
                    if let onlySunset = oneSunset["sunset"].string,
                        let theCityName = oneSunset["city"].string,
                        let theSunrise = oneSunset["sunrise"].string,
                        let theMoonPhase = oneSunset["moonPhaseDesc"].string,
                        let theMoonRise = oneSunset["moonrise"].string,
                        let theUtcTime = oneSunset["utcTime"].string,
                        let theMoonPhaseIconName = oneSunset["iconName"].string

         
                    {
                        // 3. parse the data: Convert JSON to a usable structure
                        // let parsedData = try? JSON(data: ???)
                        // 4. fill my array of FlickPictures with the data from (3)
                        //print("this is a sunset\(onlySunset)")

                        var aSunset = GoldenModel(
                            sunset:onlySunset,
                            cityName:theCityName,
                            sunrise:theSunrise,
                            moonPhase:theMoonPhase,
                            moonRise:theMoonRise,
                            utcTime:theUtcTime,
                            moonPhaseIconName:theMoonPhaseIconName
                        )
                        //print("this is a sunrise\(aSunset.sunrise)")
                        localSunsetArray.append(aSunset)
                        print("SHIIIIIIIIIIIIIIIIITTTTTTTTTT\(localSunsetArray[0].sunrise)")
                    }
                }
                // parse the data
            } else {
                print("How did I get here???")
            }
            mySunsetArray = localSunsetArray

            print("MySunSet has size \(mySunsetArray.count)")
            // last thing. If the VC gave us a task to do, do it now
            // Note: This is in backgroundThread--we need to move it to foreground if this
            //          might be controller code
            if let actualCH = completionHandler {
                // user closures are frequently UI code, so run this in the main thread
                DispatchQueue.main.async {
                    actualCH()
                }
            }

        }
     //  return myDogParksArray
 // end of data task closure
        
        //        let task = session.dataTask(with: <#T##URL#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
       task.resume()
        print("Hi, I'm here")
        return mySunsetArray

        // to do: Parse the JSON into some form of structure
        
        
    }
 
    public func getSunsetData(url: URL, completionHandler: (()->())?){
        // 2. retrieve the data
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: url) {
            // completion handler using trailing closure syntax
            (data, response, error) in
            var arrSunsets = Array<GoldenModel>()
            // write some code here
            print("I'm in \(#file) at line \(#line)")
            if let actualError = error {
                print("I got an error: \(actualError)")
            } else if let actualResponse = response,
                let actualData = data,
                let parsedData = try? JSON(data: actualData) {
                print("I got some data: \(actualData)")
                
                 print("I got some data: \(parsedData)")
                let theAstronomyData = parsedData["astronomy"]
                let theSunset = theAstronomyData["astronomy"]

                for (_, oneSunset) in theSunset {
                    print("I got a sunset: \(oneSunset)")
                    if let onlySunset = oneSunset["sunset"].string,
                        let theCityName = oneSunset["city"].string,
                        let theSunrise = oneSunset["sunrise"].string,
                        let theMoonPhase = oneSunset["moonPhaseDesc"].string,
                        let theMoonRise = oneSunset["moonrise"].string,
                        let theUtcTime = oneSunset["utcTime"].string,
                        let theMoonPhaseIconName = oneSunset["iconName"].string

                    {
                        // 3. parse the data: Convert JSON to a usable structure
                        // let parsedData = try? JSON(data: ???)
                        // 4. fill my array of FlickPictures with the data from (3)
                        //print("this is a sunset\(onlySunset)")
                        
           
                       var aSunset = GoldenModel(
                        sunset:onlySunset,
                        cityName:theCityName,
                        sunrise:theSunrise,
                        moonPhase:theMoonPhase,
                        moonRise:theMoonRise,
                        utcTime:theUtcTime,
                        moonPhaseIconName:theMoonPhaseIconName
                        )
                        //print("this is a sunrise\(aSunset.sunrise)")
                        arrSunsets.append(aSunset)
                        print("HELOOOOOOOOOOOOOOOOOO\(arrSunsets[0].sunrise)")
                    }
                }
                //print("this is a sunrise\(arrSunsets[0].sunrise)")

                
                // print("I got some data: \(theRealPhotos)")
                self.thisSunset = arrSunsets
                print("HELOOOOOOOOOOOOOOOOOO\(self.thisSunset![0].sunrise)")

            }
            print("Done with Closure. \(arrSunsets.count) rows")
            // If there is a completionHandler, dispatch it to the main thread
            DispatchQueue.main.async {
                completionHandler?()
            }
        } // End of Closure for session.dataTask()
        // the task is created stopped. We need to start it.
        print("I'm in \(#file) at line \(#line)")
        task.resume()
        print("I'm in \(#file) at line \(#line)")
        // conditional unwrap
    }
    func makeUrl()->URL {
        // 1. generate a URL to get the data
        let theURL = generateURL()
        return theURL
    }
    // This method will fill currentPhotos with recent photos
    func getSunset(completionHandler: (()->())? = nil){
        // 1. generate a URL to get the data
        let theURL = generateURL()
        getSunsetData(url: theURL, completionHandler: completionHandler)
    }
    /*
    // This method will fill currentPhotos with photos related to search term
    func getWith(searchTerm: String, completionHandler: (()->())? = nil) {
        //currentPhotos = Array<FlickrPicture>()
        // 1. generate a URL to get the data
        let theURL = generateURL(action: .Search(searchTerm))
        getSunsetData(url: theURL, completionHandler: completionHandler)
    }*/
    // done
    /*
    func getPictureCount()->Int {
        return thisSunset?.count ?? 0
    }*/
    init(){
    }
    deinit {
        // cancel all of our subscriptions. We're going to Fla for the winter
        NotificationCenter.default.removeObserver(self)
    }
    
}



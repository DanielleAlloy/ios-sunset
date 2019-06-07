//
//  WeatherModelCollection.swift
//  Capstone
//
//  Created by Danielle Alloy on 5/10/19.
//  Copyright © 2019 Danielle Alloy. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherModelCollection {
    public var thisWeekWeather: Array<Weather>?
    
    let locationManager = CLLocationManager()
    
    func getWeatherAt(row: Int)->Weather? {
        return thisWeekWeather![row]
    }
    



    private func generateURL()->URL {
        if  (locationManager.location?.coordinate != nil){

            let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
            
            let lattitude:String = String(locValue.latitude)
            let longitude:String = String(locValue.longitude)

            let baseURL = "https://weather.cit.api.here.com/weather/1.0/report.json?"
            var urlComponents = URLComponents(string: baseURL)!
            var queryItemArrays=Array<URLQueryItem>()
            queryItemArrays.append(URLQueryItem(name: "product", value:"forecast_7days_simple"))
            queryItemArrays.append(URLQueryItem(name: "latitude", value:lattitude))
            queryItemArrays.append(URLQueryItem(name: "longitude", value:longitude))
            queryItemArrays.append(URLQueryItem(name: "oneobservation", value:"true"))
            queryItemArrays.append(URLQueryItem(name: "app_id", value: GlobalConstants.APIKey.appId))
            queryItemArrays.append(URLQueryItem(name: "app_code", value: GlobalConstants.APIKey.appCode))
        
            
            
            
            print(urlComponents.string!)
            

            urlComponents.queryItems = queryItemArrays
            print(urlComponents.string!)
            return urlComponents.url!
        }else{
            
            let baseURL = "https://weather.cit.api.here.com/weather/1.0/report.json?"
            var urlComponents = URLComponents(string: baseURL)!
            var queryItemArrays=Array<URLQueryItem>()
            queryItemArrays.append(URLQueryItem(name: "product", value:"forecast_7days_simple"))
            queryItemArrays.append(URLQueryItem(name: "latitude", value:"52.516"))
            queryItemArrays.append(URLQueryItem(name: "longitude", value:"13.389"))
            queryItemArrays.append(URLQueryItem(name: "oneobservation", value:"true"))
            queryItemArrays.append(URLQueryItem(name: "app_id", value: GlobalConstants.APIKey.appId))
            queryItemArrays.append(URLQueryItem(name: "app_code", value: GlobalConstants.APIKey.appCode))
            
            
            
            
            print(urlComponents.string!)
            
            
            urlComponents.queryItems = queryItemArrays
            print(urlComponents.string!)
            return urlComponents.url!
        }
    }
    public func getWeatherData(url: URL, completionHandler: (()->())?){
        // 2. retrieve the data
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: url) {
            // completion handler using trailing closure syntax
            (data, response, error) in
            var localWeatherArray = Array<Weather>()
            // write some code here
            print("I'm in \(#file) at line \(#line)")
            if let actualError = error {
                print("I got an error: \(actualError)")
            } else if let actualResponse = response,
                let actualData = data,
                let parsedData = try? JSON(data: actualData) {
                print("I got some data: \(actualData)")
                
                print("I got some data: \(parsedData)")
                let dailyForecasts = parsedData["dailyForecasts"]
                let forecastLocation = dailyForecasts["forecastLocation"]
                let theForecast = forecastLocation["forecast"]


                for (_, oneDayWeather) in theForecast {
                    print("I got a forcast: \(oneDayWeather)")
                    if let theweatherDescription = oneDayWeather["description"].string,
                        let theSkyDescription = oneDayWeather["skyDescription"].string,
                        let theHighTemperature = oneDayWeather["highTemperature"].string,
                        let thelowTemperature = oneDayWeather["lowTemperature"].string,
                        let thePercipChance = oneDayWeather["precipitationProbability"].string,
                        let theWindSpeed = oneDayWeather["windSpeed"].string,
                        let thewindDesc = oneDayWeather["windDesc"].string,
                        let theIconName = oneDayWeather["iconName"].string,
                        let theIconLink = oneDayWeather["iconLink"].url,
                        let theWeekday = oneDayWeather["weekday"].string
                    {
                        // 3. parse the data: Convert JSON to a usable structure
                        // let parsedData = try? JSON(data: ???)
                        // 4. fill my array of FlickPictures with the data from (3)
                        //print("this is a sunset\(onlySunset)")
                        
                        var aForcast = Weather(
                            description: theweatherDescription,
                            skyDescription: theSkyDescription,
                            percipChance: thePercipChance,
                            highTemperature: theHighTemperature,
                            lowTemperature: thelowTemperature,
                            windSpeed: theWindSpeed,
                            windDesc: thewindDesc,
                            iconName: theIconName,
                            iconLink: theIconLink,
                            weekday: theWeekday
                        )
                        //print("this is a sunrise\(aSunset.sunrise)")
                        localWeatherArray.append(aForcast)
                        //print("HELOOOOOOOOOOOOOOOOOO\(arrSunsets[0].sunrise)")
                    }
                }
                //print("this is a sunrise\(arrSunsets[0].sunrise)")
                
                
                // print("I got some data: \(theRealPhotos)")
                self.thisWeekWeather = localWeatherArray
                //print("HELOOOOOOOOOOOOOOOOOO\(self.thisSunset![0].sunrise)")
                
            }
            print("Done with Closure. \(localWeatherArray.count) rows")
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

    // This method will fill currentPhotos with recent photos
    func getWeather(completionHandler: (()->())? = nil){
        // 1. generate a URL to get the data
        let theURL = generateURL()
        getWeatherData(url: theURL, completionHandler: completionHandler)
    }
    func getForcastCount()->Int {
        return thisWeekWeather?.count ?? 0
    }
    init(){
        // where there's a memory warning, call proper method

    }
    deinit {
        // cancel all of our subscriptions. We're going to Fla for the winter
        NotificationCenter.default.removeObserver(self)
    }
}

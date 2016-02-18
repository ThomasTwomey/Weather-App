//
//  WeatherService.swift
//  Weather-App-Example
//
//  Created by Tommy Twomey on 2/16/16.
//  Copyright © 2016 Toome. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {
    func setWeather(weather: Weather)
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    func getWeather(city: String) {
        
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=44db6a862fba0b067b1930da0d769e98"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            //print(">>>> \(data!)")
            let json = JSON(data: data!)
            let lon = json["coord"]["lon"].double
            let lat = json["coord"]["lat"].double
            let temp = json["main"]["temp"].double
            let name = json["name"].string
            let desc = json["weather"][0]["description"].string
            
            let weather = Weather(cityName: name!, temp: temp!, description: desc!)
            
            if self.delegate != nil{
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.setWeather(weather)
                })
                
            }
            
            print("lat: \(lat!) lon: \(lon!) temp: \(temp!)")
        }
        
        task.resume()
        
        //print("Weather Service city: \(city)")
        // request weather data
        // wait...
        // process data
        /*
        let weather = Weather(cityName: city, temp: 237.12, description: "A nice day")
        
        if delegate != nil {
            delegate?.setWeather(weather)
        }
        */
        
        // send weather data back
    }
    
    
}

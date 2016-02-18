//
//  ViewController.swift
//  Weather-App-Example
//
//  Created by Tommy Twomey on 2/16/16.
//  Copyright © 2016 Toome. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherServiceDelegate {
    
    let weatherService = WeatherService()

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBAction func setCityTapped(sender: UIButton) {
        print("City Button Tapped")
        openCityAlert()
    }
    
    func openCityAlert() {
        // Create Alert Controller
        let alert = UIAlertController(title: "City",
            message: "Enter city name",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        // Create Cancel Action
        let cancel = UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel,
            handler: nil)
        
        alert.addAction(cancel)
        
        // Create OK Action
        let ok = UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: { (action: UIAlertAction) -> Void in
                print("OK")
                let textField = alert.textFields?[0]
               // print(textField?.text!)
               // self.cityLabel.text = textField?.text!
                let cityName = textField?.text
                self.weatherService.getWeather(cityName!)
        })
        
        alert.addAction(ok)
        
        // Add Text Field
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "City Name"
        }
        
        // Present Alert Controller
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Weather Service Delegate
    
    func setWeather(weather: Weather) {
       // print("*** Set Weather")
       // print("City: \(weather.cityName) temp:\(weather.temp) desc:\(weather.description)")
        cityLabel.text = weather.cityName
        let rounded = String(format: "%.2f", weather.tempF)
        tempLabel.text = rounded + "°"
        descriptionLabel.text = weather.description
        iconImage.image = UIImage(named: weather.icon)
        //cityButton.setTitle(weather.cityName, forState: UIControlState.Normal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let topColor = UIColor(red: (24/255.0), green: (90/255.0), blue: (157/255.0), alpha: 1)
        let bottomColor = UIColor(red: (67/255.0), green: (206/255.0), blue: (162/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
        
        self.weatherService.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


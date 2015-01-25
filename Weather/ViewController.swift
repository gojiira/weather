//
//  ViewController.swift
//  Weather
//
//  Created by Philipp Ulsamer on 17.01.15.
//  Copyright (c) 2015 TheJutsu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var cloud: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var DTLabel: UILabel!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blurry.jpg")!)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let location:String = "manila"
        let wuWeatherURL: NSURL = NSURL(string:"http://api.openweathermap.org/data/2.5/weather?q=\(location)")!
        let request:NSURLRequest = NSURLRequest(URL: wuWeatherURL)
      
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            //error
            if error != nil{
                return
            }
            var parseError:NSError?
            
            let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error:&parseError)
            
            if parseError != nil {
                return
            }
            
            println(parsedObject)
            
            if let weather = parsedObject as? NSDictionary{
                if let dt = weather["dt"] as? Int{
                    if let main = weather["main"] as? NSDictionary{
                        if let humidity = main["humidity"] as? Int{
                            if let temp_max = main["temp_max"] as? Double{
                                if let temp_min = main["temp_min"] as? Double{
                                    if let temp = main["temp"] as? Double{
                                        if let pressure = main["pressure"] as? Double{
                                            if let weatherMainArray = weather["weather"] as? NSArray{
                                                if let weatherMainDic = weatherMainArray[0] as? NSDictionary{
                                                    if let weatherIcon = weatherMainDic["main"] as? String{
                                                        if let loc_name = weather["name"] as? String{
                                                            
                                                            var weatherNew:Weather = Weather(DT: dt, temp: temp, humidity: humidity, temp_min: temp_min, temp_max: temp_max, pressure: Int(pressure), seaLevel: 0, groundLevel: 0, weatherMain: weatherIcon)
                                                            
                                                            var locNew: Location = Location(ID: 1, name: loc_name, lat: 123, lon: 123, message: "" , country: "DE", sunrise: 123, sunset: 123, weather: weatherNew)
                                                            println("Temperatur: \(weatherNew.temp) Humidity: \(weatherNew.humidity) DT: \(weatherNew.DT) Temp_Max: \(weatherNew.temp_max) Temp_Min: \(weatherNew.temp_min)")

                                                            dispatch_async(dispatch_get_main_queue(), {
                                                                self.tempLabel.text = "\(Int(weatherNew.temp)) °C"
                                                                self.humidityLabel.text = "\(weatherNew.humidity) %"
                                                                self.maxTempLabel.text = "\(Int(weatherNew.temp_max)) °C"
                                                                self.minTempLabel.text = "\(Int(weatherNew.temp_min)) °C"
                                                                self.pressureLabel.text = "\(weatherNew.pressure)"
                                                                self.locationLabel.text = "\(locNew.name)"
                                                                self.cloud.image = UIImage(named: "\(weatherNew.weatherMain.rawValue)")
                                                                let dt: String = "\(weatherNew.DT)"
                                                                self.DTLabel.text = dt.substringToIndex(advance(dt.startIndex, countElements(dt)-5))
                                                            })
                                                            
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
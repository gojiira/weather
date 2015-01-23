//
//  Weather.swift
//  Weather
//
//  Created by Philipp Ulsamer on 17.01.15.
//  Copyright (c) 2015 TheJutsu. All rights reserved.
//

import UIKit
import MapKit

enum WeatherMain: String {
    case Rain = "Rainy"
    case Clouds = "Cloudy"
    case Fog = "Foggy"
    case Thunderstorm = "Thunderstormy"
    case Moon = "Moony"
    case MoonyWithClouds = "MoonyWithClouds"
    case Sun = "Sunny"
    case SunnyWithClouds = "SunnyWithClouds"
    var img: UIImage {
        return UIImage(named: self.rawValue)!
    }
}

class Weather: NSObject {
    let DT: NSDate
    let temp: Double
    let humidity: Int
    let temp_min: Double
    let temp_max : Double
    let pressure: Int
    let seaLevel: Int
    let groundLevel: Int
    let weatherMain: WeatherMain
    
    
    init(DT: Int,
        temp: Double,
        humidity: Int,
        temp_min: Double,
        temp_max: Double,
        pressure: Int,
        seaLevel: Int,
        groundLevel: Int,
        weatherMain: String) {
            
            self.DT = NSDate(timeIntervalSince1970: NSTimeInterval(DT))
            self.temp = temp - 273.15
            self.humidity = humidity
            self.temp_min = temp_min - 273.15
            self.temp_max = temp_max - 273.15
            self.pressure = pressure
            self.seaLevel = seaLevel
            self.groundLevel = groundLevel
            switch weatherMain {
            case "Rain":
                self.weatherMain = .Rain
            case "Clouds":
                self.weatherMain = .Clouds
            case "Fog":
                self.weatherMain = .Fog
            case "Sun":
                self.weatherMain = .Sun
            case "Moon":
                self.weatherMain = .Moon
            case "Thunderstorm":
                self.weatherMain = .Thunderstorm
            case "MoonyWithClouds":
                self.weatherMain = .MoonyWithClouds
            default:
                self.weatherMain = WeatherMain.SunnyWithClouds
            }
    }
}

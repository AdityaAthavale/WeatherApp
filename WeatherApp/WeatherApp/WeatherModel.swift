//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Aditya Athavale on 1/22/18.
//  Copyright © 2018 Aditya Athavale. All rights reserved.
//

import UIKit

struct WeatherData : Codable {
    struct Main : Codable {
        var humidity : Double?
        var maxTemp : Double?
        var minTemp : Double?
        var currentTemp : Double?
        var pressure : Double?

        enum CodingKeys : String, CodingKey {
            case humidity = "humidity"
            case maxTemp = "temp_max"
            case minTemp = "temp_min"
            case currentTemp = "temp"
            case pressure = "pressure"
        }
    }
    struct Weather : Codable {
        var icon : String?
        var desc : String?
        var main : String?

        enum CodingKeys : String, CodingKey {
            case icon = "icon"
            case desc = "description"
            case main = "main"
        }
    }
    var main : Main?
    var visibility : Double?
    var weather : [Weather]?
    
//    enum CodingKeys : String, CodingKey {
//        case mainWeather = "main"
//        case visibility = "visibility"
//        case weather = "weather"
//    }
}

class WeatherModel: NSObject {
    static func parseWeatherModelData(_ data : Data) -> WeatherData? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let decoder = JSONDecoder()
            let weather = try decoder.decode(WeatherData.self, from: data)
            return weather
        } catch let error {
            print("Error Parsing data")
        }
        return nil
    }
}

//
//  Weather.swift
//  Clima
//
//  Created by 笑 on 2023/9/25.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    var list: [WeatherListItem]
    var city: City
    
    var cityName: String {
        city.name
    }
    
    var temperature: Float {
        list[0].main.temp
    }
    
    var condition: String {
        
        switch list[0].weather[0].id {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        }
        
    }
    
    
}

struct WeatherListItem: Decodable {
    var main: Main
    var weather: [Weather]
}

struct Main: Decodable {
    var temp: Float
}

struct Weather: Decodable {
    var id: Int
}

struct City: Decodable {
    var name: String
}

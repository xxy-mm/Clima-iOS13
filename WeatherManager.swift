//
//  WeatherManager.swift
//  Clima
//
//  Created by 笑 on 2023/9/25.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherDelegate {
    func weatherDidUpdate(weather: WeatherData)
}


struct WeatherManager {
    
    let url = "https://api.openweathermap.org/data/2.5/forecast?appid=0599e8f894f19c8c717cb4025474ca35&units=metric"
    var delegate: WeatherDelegate?
    func getWeather(latitude lat: Double, longitude lon: Double) {
        let url = URL(string: "\(self.url)&lat=\(lat)&lon=\(lon)")
        guard let url = url else { return }
        performRequest(url: url)
    }
    func getWeather(city: String) {
        let url = URL(string: "\(self.url)&q=\(city)")
        guard let url = url else { return }
        performRequest(url: url)
    }
    
    func performRequest(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.handleClientError(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                delegate?.weatherDidUpdate(weather: weatherData)
            } catch {
                handleParseJSONError(error)
            }
        }
        task.resume()
    }
    func handleClientError(_ error: Sendable) {
        print("client error: ", error)
    }
    func handleServerError(_ error: Sendable) {
        print("server error: ", error)
    }
    func handleParseJSONError(_ error: Error) {
        print("parsing json error: \(error)")
    }
    
}

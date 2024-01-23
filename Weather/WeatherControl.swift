//
//  WeatherControl.swift
//  Weather
//
//  Created by spark-04 on 2024/01/12.
//

import Foundation
import UIKit
import YumemiWeather

struct WeatherArea: Codable {
    var area: String
    var date: String
}

struct WeatherResponse: Codable {
    let weather_condition: String
    let max_temperature: Int
    let min_temperature: Int
}

class YumemiTenkiDetail {
  
    func setYumemiWeatherInfo(completion: @escaping (Result<(String,Int,Int),Error>) -> ()) {
        
        DispatchQueue.global().async {
            let requestJson = WeatherArea(area: "tokyo", date: "2020-04-01T12:00:00+09:00")
            
            do {
                let encoder = JSONEncoder()
                let yumemiJsonDate = try encoder.encode(requestJson)
                guard let jsonData = String(data: yumemiJsonDate, encoding: .utf8) else {
                    completion(.failure(YumemiWeatherError.unknownError))
                    return
                }
                
                let weatherCondition = try YumemiWeather.syncFetchWeather(jsonData)
                
                guard let jsonData =  weatherCondition.data(using: .utf8) else {
                    completion(.failure(YumemiWeatherError.unknownError))
                    return
                }
                
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: jsonData)
                
                DispatchQueue.main.async {
                    completion(.success((weatherResponse.weather_condition, weatherResponse.max_temperature, weatherResponse.min_temperature)))
                }
                
            } catch YumemiWeatherError.unknownError {
                completion(.failure(YumemiWeatherError.unknownError))
                
            } catch let error {
                print(error)
            }
        }
    }

}








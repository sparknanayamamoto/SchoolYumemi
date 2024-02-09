//
//  WeatherControl.swift
//  Weather
//
//  Created by spark-04 on 2024/01/12.
//

import Foundation
import UIKit
import YumemiWeather


class YumemiTenkiDetail {
    
    func setYumemiWeatherInfo() async -> Result<(String,Int,Int),Error> {
        
        let requestJson = WeatherArea(area: "tokyo", date: "2020-04-01T12:00:00+09:00")
        
        do {
            let encoder = JSONEncoder()
            let yumemiJsonDate = try encoder.encode(requestJson)
            guard let jsonData = String(data: yumemiJsonDate, encoding: .utf8) else {
                return (.failure(YumemiWeatherError.unknownError))
            }
            
            let weatherCondition = try await YumemiWeather.asyncFetchWeather(jsonData)
            
            guard let jsonData =  weatherCondition.data(using: .utf8) else {
                return  (.failure(YumemiWeatherError.unknownError))
            }
            
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: jsonData)
            return (.success((weatherResponse.weather_condition, weatherResponse.max_temperature, weatherResponse.min_temperature)))
            
        } catch YumemiWeatherError.unknownError {
            return (.failure(YumemiWeatherError.unknownError))
            
        } catch let error {
            print(error)
            return (.failure(YumemiWeatherError.unknownError))
        }
    }
    
}










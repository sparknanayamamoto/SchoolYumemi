//
//  WeatherListModel.swift
//  Weather
//
//  Created by spark-04 on 2024/01/29.
//

import Foundation
import UIKit
import YumemiWeather

struct AreaRequest: Codable {
    let areas: [String]
    let date: String
}

struct AreaResponse: Codable {
    let area: Area
    let info: WeatherResponse
}




class WeatherDetailList {
    
    
    func setYumemiWeatherList() async -> Result<[AreaResponse],Error> {
        let date = Date().ISO8601Format()
        let requestJson = AreaRequest(areas: [], date: date)
        print(requestJson)
        
        do {
            let encoder = JSONEncoder()
            let yumemiJsonDate = try encoder.encode(requestJson)
            guard let jsonData = String(data: yumemiJsonDate, encoding: .utf8) else {
                return .failure(YumemiWeatherError.unknownError)
            }
            
            let weatherCondition = try await YumemiWeather.asyncFetchWeatherList(jsonData)
            print(weatherCondition)
            guard let jsonData =  weatherCondition.data(using: .utf8) else {
                return .failure(YumemiWeatherError.unknownError)
            }
            
            let decoder = JSONDecoder()
            let response = try decoder.decode([AreaResponse].self, from: jsonData)
            print(response)
            return .success(response)
            
        } catch YumemiWeatherError.unknownError {
            return .failure(YumemiWeatherError.unknownError)
            
        } catch let error {
            print(error)
            return .failure(YumemiWeatherError.unknownError)
        }
    }
}

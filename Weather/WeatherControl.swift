//
//  WeatherControl.swift
//  Weather
//
//  Created by spark-04 on 2024/01/12.
//

import Foundation
import UIKit
import YumemiWeather


// プロトコル
protocol YumemiDelegate {
    func setWeatherImage(type: String)
    func setErrorWeather(alertMessage: String)
    func setMinTemperature(min: Int)
    func setMaxTemperature(max: Int)
    
}

// 処理を任されるクラス
class YumemiTenki {
    var delegate: YumemiDelegate?
    
    func setYumemiWeather() {
        let requestJson = """
           {
               "area":"tokyo", "date":"2020-04-01T12:00:00+09:00"
           }
           """
        do {
            let weatherCondition = try YumemiWeather.fetchWeather(requestJson)
            // print(weatherCondition)
            
            guard let jsonData =  weatherCondition.data(using: .utf8),
                  let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                  let minTemperature = json["min_temperature"] as? Int,
                  let maxTemperature = json["max_temperature"] as? Int,
                  let weatherCondition = json["weather_condition"] as? String
                    
            else {
                return
            }
            
            self.delegate?.setWeatherImage(type: weatherCondition)
            self.delegate?.setMinTemperature(min: minTemperature)
            self.delegate?.setMaxTemperature(max: maxTemperature)
            
            
        } catch YumemiWeatherError.unknownError {
            self.delegate?.setErrorWeather(alertMessage: "不明なエラーが発生しました")
            
        } catch let error {
            print(error)
        }
    }
    
}






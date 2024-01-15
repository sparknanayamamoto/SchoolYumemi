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
}

// 処理を任されるクラス
class YumemiTenki {
    var delegate: YumemiDelegate?
    
    func setYumemiWeather() {
        do {
            let weatherStrings = try YumemiWeather.fetchWeatherCondition(at: "")
            self.delegate?.setWeatherImage(type: weatherStrings)
        } catch YumemiWeatherError.unknownError {
            self.delegate?.setErrorWeather(alertMessage: "不明なエラーが発生しました")
            
        } catch let error {
            print(error)
        }
    }
    
}

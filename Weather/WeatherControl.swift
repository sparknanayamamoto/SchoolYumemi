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
}

// 処理を任されるクラス
class YumemiTenki {
    var delegate: YumemiDelegate?
    
    func setYumemiWeather() {
        let weatherStrings = YumemiWeather.fetchWeatherCondition()
        delegate?.setWeatherImage(type: weatherStrings)
    }
    
}

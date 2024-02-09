//
//  Area.swift
//  Weather
//
//  Created by spark-04 on 2024/02/09.
//

import Foundation
import YumemiWeather

struct AreaRequest: Codable {
    let areas: [String]
    let date: String
}

struct AreaResponse: Codable {
    let area: Area
    let info: WeatherResponse
}

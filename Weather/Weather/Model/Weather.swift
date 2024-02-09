//
//  Weather.swift
//  Weather
//
//  Created by spark-04 on 2024/02/09.
//

import Foundation

struct WeatherArea: Codable {
    var area: String
    var date: String
}

struct WeatherResponse: Codable {
    let weather_condition: String
    let max_temperature: Int
    let min_temperature: Int
}

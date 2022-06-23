//
//  WeatherModel.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 23.06.2022.
//

import Foundation

// MARK: - Weather
public struct Weather: Codable {
    let weather: [WeatherElement]
    let main: Main
    let wind: Wind
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let main, weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
}

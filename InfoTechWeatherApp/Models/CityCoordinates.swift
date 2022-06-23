//
//  CityCoordinates.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import Foundation

public struct CityCoordinates: Codable {
    let longitude: Double
    let latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

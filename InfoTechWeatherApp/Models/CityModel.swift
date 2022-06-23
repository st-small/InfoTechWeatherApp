//
//  CityModel.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import Foundation

public struct CityModel: Codable {
    let id: UInt
    let name: String
    let state: String
    let country: String
    let coordinates: CityCoordinates
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case state = "state"
        case country = "country"
        case coordinates = "coord"
    }
}

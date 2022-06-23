//
//  CityAvatar.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import Foundation

public enum CityAvatar: String {
    case first, second
    
    mutating func toggle() {
        switch self {
        case .first:
            self = .second
        case .second:
            self = .first
        }
    }
    
    var avatarLink: String {
        switch self {
        case .first:
            return "https://infotech.gov.ua/storage/img/Temp1.png"
        case .second:
            return "https://infotech.gov.ua/storage/img/Temp3.png"
        }
    }
}

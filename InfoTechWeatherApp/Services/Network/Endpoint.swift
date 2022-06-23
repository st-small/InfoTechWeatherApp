//
//  Endpoint.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 23.06.2022.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
}

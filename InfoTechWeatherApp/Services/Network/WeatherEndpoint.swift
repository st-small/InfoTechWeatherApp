//
//  WeatherEndpoint.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 23.06.2022.
//

import Foundation

enum WeatherEndpoint {
    case current(CityCoordinates)
}

extension WeatherEndpoint: Endpoint {
    var path: String {
        switch self {
        case .current(let coordinates):
            return "weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(Constants.apiKey)&units=metric"
        }
    }

    var method: RequestMethod {
        switch self {
        case .current:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .current:
            return nil
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .current:
            return nil
        }
    }
}

public protocol WeatherServiceable {
    func getCurrent(_ coordinates: CityCoordinates) async -> Result<Weather, RequestError>
}

public struct WeatherService: HTTPClient, WeatherServiceable {
    public func getCurrent(_ coordinates: CityCoordinates) async -> Result<Weather, RequestError> {
        return await sendRequest(endpoint: WeatherEndpoint.current(coordinates), responseModel: Weather.self)
    }
}

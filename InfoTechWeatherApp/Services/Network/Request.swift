//
//  Request.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 22.06.2022.
//

import Foundation

struct Constants {
    static let apiKey = "f98e9a4853b6542f39b4d4bd709c0f99"
    
}

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        default:
            return "Unknown error"
        }
    }
}




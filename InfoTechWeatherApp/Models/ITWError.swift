//
//  ITWError.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import Foundation

public enum ITWError: Error, LocalizedError {
    case fileNotFound(String?)
    case getDataError(String?)
    case dataParsingError(String?)
    
    public var errorDescription: String? {
        switch self {
        case .fileNotFound (let type):
            return "File Not Found \(type ?? "")"
        case .getDataError (let type):
            return "Data Retrieval Error \(type ?? "")"
        case .dataParsingError (let type):
            return "Data Parsing Error \(type ?? "")"
        }
    }
}

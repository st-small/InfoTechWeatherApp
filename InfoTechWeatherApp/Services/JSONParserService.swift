//
//  JSONParserService.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import Foundation

public enum JSONParserType {
    case cities
    
    public var fileName: String? {
        switch self {
        case .cities:
            return "city_list"
        }
    }
}

public protocol JSONParseable {
    func parse<T:Decodable>(model: T.Type, type: JSONParserType) throws -> T?
}

public final class JSONParserService: JSONParseable {
    
    // MARK: Public methods
    public func parse<T:Decodable>(model: T.Type, type: JSONParserType) throws -> T? {
        
        guard let path = Bundle.main.path(forResource: type.fileName, ofType: "json")
        else {
            throw ITWError.fileNotFound("\(model)")
        }
        
        let url = URL(fileURLWithPath: path)
        var data: Data?
        
        do {
            data = try Data(contentsOf: url, options: .mappedIfSafe)
        } catch {
            throw ITWError.getDataError("\(model)")
        }
        
        guard let parseData = data else {
            throw ITWError.getDataError("\(model)")
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: parseData)
        } catch {
            print(error)
            throw ITWError.dataParsingError("\(model)")
        }
    }
}

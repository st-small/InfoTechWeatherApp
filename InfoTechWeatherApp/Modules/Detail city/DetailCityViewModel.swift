//  
//  DetailCityViewModel.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 21.06.2022.
//

import Combine
import Foundation

public final class DetailCityViewModel {
    
    public enum Action { }
    
    // MARK: - Data
    @Published
    private(set) var coordinates: CityCoordinates
    
    @Published
    private(set) var weatherInfo: Weather?
    
    @Published
    private(set) var errorMessage: String?
    
    @Published
    public var action = PassthroughSubject<Action, Never>()
    
    private var service: WeatherServiceable
    private var cancellables: Set<AnyCancellable> = []
    
    public init(_ city: CityModel, service: WeatherServiceable) {
        coordinates = city.coordinates
        self.service = service
        fetchWeatherData()
    }
    
    private func fetchWeatherData() {
        Task(priority: .background) {
            let result = await service.getCurrent(coordinates)
            switch result {
            case .success(let weatherResponse):
                weatherInfo = weatherResponse
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}

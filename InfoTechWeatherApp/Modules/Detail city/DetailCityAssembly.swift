//  
//  DetailCityAssembly.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 21.06.2022.
//

import Foundation

public final class DetailCityAssembly {
    
    private var viewController: DetailCityViewController?
    private let city: CityModel
    
    public var view: DetailCityViewController {
        guard let view = viewController else {
            viewController = DetailCityViewController()
            configureModule(viewController)
            return viewController!
        }
        return view
    }
    
    init(_ city: CityModel) {
        self.city = city
    }
    
    private func configureModule(_ view: DetailCityViewController?) {
        guard let view = view else { return }
        view.viewModel = DetailCityViewModel(city, service: WeatherService())
    }
}

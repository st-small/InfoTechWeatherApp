//  
//  CitiesListAssembly.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import Foundation

public final class CitiesListAssembly {
    
    private var viewController: CitiesListViewController?
    
    public var view: CitiesListViewController {
        guard let view = viewController else {
            viewController = CitiesListViewController()
            configureModule(viewController)
            return viewController!
        }
        return view
    }
    
    private func configureModule(_ view: CitiesListViewController?) {
        guard let view = view else { return }
        view.viewModel = CitiesListViewModel(jsonParser: JSONParserService())
    }
}

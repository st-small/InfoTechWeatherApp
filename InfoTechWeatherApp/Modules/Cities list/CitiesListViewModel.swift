//  
//  CitiesListViewModel.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import Combine
import Foundation

public final class CitiesListViewModel {
    
    public enum Action {
        case onAppear
        case search(String)
        case searchCancelled
    }
    
    // MARK: - Data
    @Published
    private(set) var loading: Bool = false
    
    @Published
    private(set) var citiesToShow: [CityViewModel] = []
    
    @Published
    public var action = PassthroughSubject<Action, Never>()
    
    private var cityModels: [CityModel] = []
    private var cities: [CityViewModel] = []
    private var avatar: CityAvatar = .first
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Services
    private let jsonParser: JSONParseable
    
    public init(jsonParser: JSONParseable) {
        self.jsonParser = jsonParser
        
        action
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                switch action {
                case .onAppear:
                    self?.prepareData()
                case .search(let key):
                    self?.filterData(key)
                case .searchCancelled:
                    self?.citiesToShow = self?.cities ?? []
                }
            }
            .store(in: &cancellables)
    }
    
    public func getCityByID(_ id: UInt) -> CityModel? {
        cityModels.first(where: { $0.id == id })
    }
    
    private func prepareData() {
        guard cities.isEmpty else {
            loading = false
            return
        }
        
        cityModels = (try? jsonParser.parse(model: [CityModel].self, type: .cities)) ?? []
        cities = cityModels
            .map { prepareCityViewModel($0) }
            .compactMap { $0 }
        citiesToShow = cities
    }
    
    private func prepareCityViewModel(_ model: CityModel) -> CityViewModel {
        defer { avatar.toggle() }
        return CityViewModel(
            id: model.id,
            name: model.name,
            avatar: avatar.avatarLink
        )
    }
    
    private func filterData(_ key: String) {
        guard !key.isEmpty else { return }
        citiesToShow = cities.filter { $0.name.contains(key) }
    }
}

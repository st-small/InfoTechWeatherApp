//
//  CitiesTableView.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import Combine
import UIKit

public final class CitiesTableView: UITableView {
    
    public enum Action {
        case didSelectCity(UInt)
    }

    // MARK: - Data
    private let cellHeight: CGFloat = 70
    private var data = [CityViewModel]()

    public var action = PassthroughSubject<Action, Never>()

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        delegate = self
        dataSource = self

        separatorStyle = .none
    }

    public func configure(data: [CityViewModel]) {
        self.data = data
        reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CitiesTableView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseId, for: indexPath) as! CityTableViewCell
        cell.configure(model: data[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CitiesTableView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        action.send(.didSelectCity(data[indexPath.row].id))
    }
}

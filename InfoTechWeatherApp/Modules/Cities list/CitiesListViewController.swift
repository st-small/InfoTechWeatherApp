//  
//  CitiesListViewController.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import Combine
import UIKit

public final class CitiesListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var citiesTableView: CitiesTableView!
    
    private let searchController = UISearchController()
    
    // MARK: - Data
    public var viewModel: CitiesListViewModel!
    private var spinner: SpinnerViewController!
    
    private var cancellables: Set<AnyCancellable> = []
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createSpinnerView()
        viewModel.action.send(.onAppear)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.$loading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                state == true ? self?.createSpinnerView() : self?.removeSpinnerView()
            }
            .store(in: &cancellables)
        
        viewModel.$citiesToShow
            .receive(on: DispatchQueue.main)
            .drop(while: { $0.isEmpty })
            .sink { [weak self] items in
                self?.removeSpinnerView()
                self?.updateTableView()
                self?.configureSearchController()
            }
            .store(in: &cancellables)
        
        configureNavigation()
        configureTableView()
    }
    
    private func configureSearchController() {
        guard navigationItem.searchController == nil else { return }
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func configureNavigation() {
        navigationItem.title = "Cities list"
    }
    
    private func configureTableView() {
        citiesTableView.register(CityTableViewCell.cellNib, forCellReuseIdentifier: CityTableViewCell.reuseId)
        
        citiesTableView.action
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                switch action {
                case .didSelectCity(let id):
                    self?.showDetailCity(id)
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateTableView() {
        citiesTableView.configure(data: viewModel.citiesToShow)
    }
    
    func createSpinnerView() {
        spinner = SpinnerViewController()
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    func removeSpinnerView() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }

    private func showDetailCity(_ id: UInt) {
        guard let city = viewModel.getCityByID(id) else {
            showErrorAlert()
            return
        }
        let detailAssemblyView = DetailCityAssembly(city).view
        detailAssemblyView.modalPresentationStyle = .fullScreen
        navigationController?.present(detailAssemblyView, animated: true)
    }
    
    private func showErrorAlert() {
        ITWAlert.showAlertOnMain(
            title: "Error",
            message: "Something went wrong, coordinates for selected city are missing...",
            actions: [.ok(handler: { _ in })],
            from: self)
    }
}

// MARK: - UISearchResultsUpdating
extension CitiesListViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        viewModel.action.send(.search(searchController.searchBar.text ?? ""))
    }
}

// MARK: - UISearchBarDelegate
extension CitiesListViewController: UISearchBarDelegate {
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.action.send(.searchCancelled)
        view.endEditing(false)
    }
}

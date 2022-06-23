//  
//  DetailCityViewController.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 21.06.2022.
//

import Combine
import CoreLocation
import MapKit
import UIKit

public final class DetailCityViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var mapViewImage: UIImageView!
    @IBOutlet private weak var weatherInfoView: WeatherInfoView!
    @IBOutlet private weak var mainScrollView: UIScrollView!
    
    // MARK: - Data
    public var viewModel: DetailCityViewModel!
    
    private var cancellables: Set<AnyCancellable> = []
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.alpha = 1
        mapViewImage.alpha = 0
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.$coordinates
            .receive(on: DispatchQueue.main)
            .sink { [weak self] coordinates in
                self?.configureMap(coordinates)
                self?.mainScrollView.isScrollEnabled = false
            }
            .store(in: &cancellables)

        viewModel.$weatherInfo
            .receive(on: DispatchQueue.main)
            .drop(while: { $0 == nil })
            .sink { [weak self] info in
                self?.weatherInfoView.configure(info!)
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .drop(while: { $0 == nil })
            .sink { [weak self] message in
                guard let self = self else { return }
                ITWAlert.showAlertOnMain(title: "Error", message: message!, actions: [.ok(handler: { _ in })], from: self)
            }
            .store(in: &cancellables)
    }
    
    private func configureMap(_ coordinates: CityCoordinates) {
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        mapView?.delegate = self
        mapView?.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), animated: false)
        
        let delta = CLLocationDegrees(0.7)
        let theSpan = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let pointLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegion(center: pointLocation, span: theSpan)
        mapView?.setRegion(region, animated: false)
    }

    // MARK: - Actions
    @IBAction private func didTapBackButton() {
        dismiss(animated: true)
    }
}

// MARK: - MKMapViewDelegate
extension DetailCityViewController: MKMapViewDelegate {
    
    public func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        guard fullyRendered else { return }
        let options = MKMapSnapshotter.Options()
        options.region = MKCoordinateRegion(center: mapView.centerCoordinate, span: mapView.region.span)
        options.size = mapView.bounds.size
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            let snapshot = MKMapSnapshotter(options: options)
            snapshot.start { snapshot, error in
                guard let snapshot = snapshot, error == nil else { return }
                
                let image = UIGraphicsImageRenderer(size: options.size).image { _ in
                    snapshot.image.draw(at: .zero)
                    
                    let pinView = MKPinAnnotationView(annotation: nil, reuseIdentifier: nil)
                    let pinImage = pinView.image
                    
                    var point = snapshot.point(for: mapView.centerCoordinate)
                    
                    if self.mapViewImage.bounds.contains(point) {
                        point.x -= pinView.bounds.width / 2
                        point.y -= pinView.bounds.height / 2
                        point.x += pinView.centerOffset.x
                        point.y += pinView.centerOffset.y
                        pinImage?.draw(at: point)
                    }
                }
                
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.9) {
                        self.mapView.alpha = 0
                        self.mapView.isHidden = true
                        self.mapViewImage.image = image
                        self.mapViewImage.alpha = 1
                        self.mainScrollView.isScrollEnabled = true
                    }
                }
            }
        }
    }
}

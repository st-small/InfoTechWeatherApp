//
//  WeatherInfoView.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 22.06.2022.
//

import UIKit

public final class WeatherInfoView: UIView, NibOwnerLoadable {

    // MARK: - Outlets
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var cityWeatherDescription: UILabel!
    @IBOutlet private weak var currentTemp: UILabel!
    @IBOutlet private weak var currentTempDescription: UILabel!
    @IBOutlet private weak var minTempValue: UILabel!
    @IBOutlet private weak var minTempValueDescription: UILabel!
    @IBOutlet private weak var maxTempValue: UILabel!
    @IBOutlet private weak var maxTempValueDescription: UILabel!
    @IBOutlet private weak var humidityValue: UILabel!
    @IBOutlet private weak var humidityDescription: UILabel!
    @IBOutlet private weak var windSpeedValue: UILabel!
    @IBOutlet private weak var windSpeedDescription: UILabel!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
        initialSetup()
    }
    
    private func initialSetup() {
        configureContainer()
        [cityName, cityWeatherDescription, currentTemp, currentTempDescription, minTempValue, minTempValueDescription, maxTempValue, maxTempValueDescription, humidityValue, humidityDescription, windSpeedValue, windSpeedDescription]
            .forEach { $0?.alpha = 0 }
    }
    
    public func configure(_ model: Weather) {
        cityName.text = model.name
        
        if let info = model.weather.first {
            cityWeatherDescription.text = "\(info.main), \(info.weatherDescription)"
        }
        
        currentTemp.text = "\(Int(model.main.temp))℃"
        minTempValue.text = "\(Int(model.main.tempMin))℃"
        maxTempValue.text = "\(Int(model.main.tempMax))℃"
        
        humidityValue.text = "\(model.main.humidity)%"
        
        windSpeedValue.text = "\(model.wind.speed)m/s"
        
        UIView.animate(withDuration: 0.3) {
            [self.cityName, self.cityWeatherDescription, self.currentTemp, self.currentTempDescription, self.minTempValue, self.minTempValueDescription, self.maxTempValue, self.maxTempValueDescription, self.humidityValue, self.humidityDescription, self.windSpeedValue, self.windSpeedDescription]
                .forEach { $0?.alpha = 1 }
        }
    }
    
    private func configureContainer() {
        container.layer.cornerRadius = 16
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

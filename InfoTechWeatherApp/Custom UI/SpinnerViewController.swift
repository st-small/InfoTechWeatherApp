//
//  SpinnerViewController.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import UIKit

public final class SpinnerViewController: UIViewController {
    
    private var spinner = UIActivityIndicatorView(style: .large)

    public override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

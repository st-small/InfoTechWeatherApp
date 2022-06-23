//
//  ITWSingleLineNavigationController.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import UIKit

public final class ITWSingleLineNavigationController: UINavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.backgroundColor = UIColor(named: "bg")
        navBarAppearance.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28, weight: .semibold)
        ]
        
        navigationBar.prefersLargeTitles = false
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = UIColor.black
    }
}

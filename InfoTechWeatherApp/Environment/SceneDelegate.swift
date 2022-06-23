//
//  SceneDelegate.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let citiesListAssembly = CitiesListAssembly()
        let navigator = ITWSingleLineNavigationController(rootViewController: citiesListAssembly.view)
        window.rootViewController = navigator
        self.window = window
        window.makeKeyAndVisible()
    }
}


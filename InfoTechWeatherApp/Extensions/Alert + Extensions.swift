//
//  Alert + Extensions.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 21.06.2022.
//

import UIKit

public struct ITWAlert {
    
    public static func showAlertOnMain(title: String?, message: String, actions: [ITWAlert.Action], from controller: UIViewController) {
        DispatchQueue.main.async {
            self.present(title: title, message: message, actions: actions, from: controller)
        }
    }
    
    private static func present(title: String?, message: String, actions: [ITWAlert.Action], from controller: UIViewController) {
        
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alertController.addAction(action.alertAction)
        }
        
        controller.present(alertController, animated: true, completion: nil)
    }
}

extension ITWAlert {
    
    public static var alertController = UIAlertController()
    
    public enum Action {
        case ok(handler: ((UIAlertController?) -> Void)?)
        
        private var title: String {
            switch self {
            case .ok:
                return "OK"
            }
        }
        
        // Returns the completion handler of our button
        private var handler: ((UIAlertController?) -> Void)? {
            switch self {
            case .ok(let handler):
                return handler
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .ok:
                return .default
            }
        }
        
        var alertAction: UIAlertAction {
            return UIAlertAction(title: title, style: style, handler: { action in
                if let handler = self.handler {
                    handler(alertController)
                }
            })
        }
    }
}

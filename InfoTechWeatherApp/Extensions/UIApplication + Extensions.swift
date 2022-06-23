//
//  UIApplication + Extensions.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 21.06.2022.
//

import UIKit

//extension UIApplication {
//    
//    static var keyWindow: UIWindow? {
//        UIApplication
//        .shared
//        .connectedScenes
//        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
//        .first { $0.isKeyWindow }
//    }
//    
//    var icon: UIImage? {
//        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? NSDictionary,
//            let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? NSDictionary,
//            let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? NSArray,
//            let lastIcon = iconFiles.lastObject as? String,
//            let icon = UIImage(named: lastIcon) else {
//                return nil
//        }
//
//        return icon
//    }
//    
//    static var safeAreaInsets: UIEdgeInsets? {
//        keyWindow?.safeAreaInsets
//    }
//}

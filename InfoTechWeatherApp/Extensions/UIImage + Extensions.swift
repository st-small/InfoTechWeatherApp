//
//  UIImage + Extensions.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import UIKit

private let imageCache = NSCache<AnyObject, AnyObject>()
private let activityView = UIActivityIndicatorView(style: .medium)

extension UIImageView {
    func loadRemoteImageFrom(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        image = nil
        
        activityView.center = self.center
        addSubview(activityView)
        activityView.startAnimating()
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            activityView.stopAnimating()
            activityView.removeFromSuperview()
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                activityView.stopAnimating()
                activityView.removeFromSuperview()
            }
            
            if let response = data {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: response) {
                        imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                        self.image = imageToCache
                    }
                }
            }
        }
        .resume()
    }
}

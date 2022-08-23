//
//  DownloadableImageView.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class DownloadableImageView: UIImageView {
    
    var urlString: String?
    var dataTask: URLSessionDataTask?
    
    func downloadWithUrlSession(at cell: UITableViewCell, urlStr: String) {
        urlString = urlStr
        
        guard let url = URL(string: urlStr) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlStr as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        self.dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                if self.urlString == urlStr {
                    self.image = image
                }
                imageCache.setObject(image, forKey: urlStr as AnyObject)
            }
        }
        dataTask?.resume()
    }
    
    func cancelLoadingImage() {
        dataTask?.cancel()
        dataTask = nil
    }
}

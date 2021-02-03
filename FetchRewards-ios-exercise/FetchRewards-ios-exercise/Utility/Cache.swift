//
//  Cache.swift
//  FetchRewards-ios-exercise
//
//  Created by Iyin Raphael on 2/2/21.
//

import UIKit.UIImageView

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        // if not, download image from url
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            if let image = UIImage(data: data!) {
                imageCache.setObject(image, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}

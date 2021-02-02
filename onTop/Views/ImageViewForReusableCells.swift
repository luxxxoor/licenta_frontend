//
//  ImageViewForReusableCells.swift
//  onTop
//
//  Created by Alexandru Vrincean on 04/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import UIKit

class ImageViewForReusableCells: UIImageView {
    private var imageUrl: URL?
    
    func loadImageUsingUrl(_ url: URL) {
        imageUrl = url
        
        let absoluteString = url.absoluteString as NSString
        let imageCache = NSCache<NSString, UIImage>()
        
        if let imageFromCache = imageCache.object(forKey: absoluteString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                [weak self] in
                guard let self = self else { return }
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrl == url {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: absoluteString)
            }
        }.resume()
    }
}

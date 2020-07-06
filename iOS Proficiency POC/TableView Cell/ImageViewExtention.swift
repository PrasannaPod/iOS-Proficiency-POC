//
//  ImageViewExtention.swift
//  iOS Proficiency POC
//
//  Created by prasu on 04/07/20.
//  Copyright © 2020 prasanna. All rights reserved.
//

import Foundation
import UIKit

// Create the protocol
protocol Cachable {}

// creating a imageCache private instance
private  let imageCache = NSCache<NSString, UIImage>()

// UIImageview conforms to Cachable
extension UIImageView: Cachable {}

// creating a protocol extension to add optional function implementations,
extension Cachable where Self: UIImageView {

    // creating the function
    typealias SuccessCompletion = (Bool) -> Void
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?, completion: @escaping SuccessCompletion) {

        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion(true)
            }
            return
        }
        self.image = placeHolder

        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, _) in

                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {

                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            DispatchQueue.main.async {
                                self.image = downloadedImage
                                completion(true)
                            }
                        }
                    }
                } else {
                    self.image = placeHolder
                }
            }).resume()
        } else {
            self.image = placeHolder
        }
    }
}

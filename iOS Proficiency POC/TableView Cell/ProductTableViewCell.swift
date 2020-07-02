//
//  ProductTableViewCell.swift
//  iOS Proficiency POC
//
//  Created by prasu on 01/07/20.
//  Copyright © 2020 prasanna. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    // Define label, imageView etc
    lazy var productName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.numberOfLines = 5
        return label
    }()
    lazy var productDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.gray
        label.numberOfLines = 25
        return label
    }()
    lazy var productImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // initialise tableView cell with Sub views
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(productName)
        self.contentView.addSubview(productDescription)
        self.contentView.addSubview(productImageView)
        creatingConstraintsforEachViewAdded()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    //Constraints for each view
    func creatingConstraintsforEachViewAdded() {
        // constraints for image view
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        productImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: productName.topAnchor).isActive = true
       //constraints for title
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.topAnchor.constraint(equalTo: productImageView.bottomAnchor).isActive = true
        productName.bottomAnchor.constraint(equalTo: productDescription.topAnchor).isActive = true
        productName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        productName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        // constraints fir Description
        productDescription.translatesAutoresizingMaskIntoConstraints = false
        productDescription.topAnchor.constraint(equalTo: productName.bottomAnchor).isActive = true
        productDescription.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        productDescription.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        productDescription.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
    
    // to make padding from super view
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
}

// custom class to maintain cache of image View in table view cell
let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    var imageUrlString: String?

    func downloadImageFrom(withUrl urlString: String) {
        imageUrlString = urlString
        // converting string to image url
        let url = URL(string: urlString)
        self.image = nil

        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        // downloading image from URL
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, error) in
            if error != nil {
                print(error!)
                return
            }
            // updating image view
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: NSString(string: urlString))
                    if self.imageUrlString == urlString {
                        self.image = image
                    }
                }
            }
        }).resume()
    }
}

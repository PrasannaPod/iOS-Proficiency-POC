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
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    //Constraints for each view
    func creatingConstraintsforEachViewAdded() {
        // constraints for image view
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        productImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: productName.topAnchor, constant: -15).isActive = true
       //constraints for title
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 15).isActive = true
        productName.bottomAnchor.constraint(equalTo: productDescription.topAnchor, constant: -15).isActive = true
        productName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        productName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
        // constraints fir Description
        productDescription.translatesAutoresizingMaskIntoConstraints = false
        productDescription.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 15).isActive = true
        productDescription.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15).isActive = true
        productDescription.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        productDescription.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
    }

}

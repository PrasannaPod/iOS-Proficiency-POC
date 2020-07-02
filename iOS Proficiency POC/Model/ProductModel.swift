//
//  ProductModel.swift
//  iOS Proficiency POC
//
//  Created by prasu on 01/07/20.
//  Copyright © 2020 prasanna. All rights reserved.
//

import UIKit

class ProductModel: NSObject {
    var productName: String
    var productImageurl: String
    var productDescription: String
// Model Class for APi response data
    init(name: String, imageurl: String, description: String) {
        self.productName = name
        self.productImageurl = imageurl
        self.productDescription = description
    }
}

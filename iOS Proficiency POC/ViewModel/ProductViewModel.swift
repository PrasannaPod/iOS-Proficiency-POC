//
//  ProductViewModel.swift
//  iOS Proficiency POC
//
//  Created by prasu on 01/07/20.
//  Copyright © 2020 prasanna. All rights reserved.
//

import UIKit

class ProductViewModel: NSObject, webclassdelegate {

    var productTableTitle: String

    // Closure use to notify view
       var reloadList = {() -> Void in }
       var errorMessage = {(message: String) -> Void in }

    init(title: String) {
         self.productTableTitle = title
    }

    //Array of List Model class
    var productsArray: [ProductModel] = [] {
        //Reload data when data set
        didSet {
            reloadList()
        }
    }

    // MARK: - API Related methods
    //calling API
    func callingAPItoGetProductDetails() {
        let webclassObject = WebClass()
        webclassObject.webdelegate = self
        webclassObject.requestWithURL(requestUrl: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
    }
    // get API response
    func getResponse(result: NSDictionary) {
        self.productTableTitle = (result["title"] as? String)!
        let dummyArray: Array = (result["rows"] as? [Any])!
        // Saving dat by using Product Model
        for case let productDictionary as NSDictionary in dummyArray {
            let product = ProductModel(name: productDictionary["title"] as? String ?? "", imageurl: productDictionary["imageHref"] as? String ?? "", description: productDictionary["description"] as? String ?? "" )
            productsArray.append(product)
        }

    }
    // get API response error
    func getErrorResponse(error: NSString) {
        print(error)
    }
}

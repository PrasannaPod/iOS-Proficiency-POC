//
//  iOS_Proficiency_POCTests.swift
//  iOS Proficiency POCTests
//
//  Created by prasu on 01/07/20.
//  Copyright © 2020 prasanna. All rights reserved.
//

import XCTest
import UIKit

@testable import iOS_Proficiency_POC

class IOSProficiencyPOCTests: XCTestCase {

    let productTableView = ProductTableViewController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        productTableView.addingRefreshControllerToTableView()
    }

    func testRefreshControllerMethod() {
       let productViewModel: ProductViewModel = ProductViewModel(title: "viewTitle")
        let product = ProductModel(name: "title", imageurl: "imageURL", description: "description" )
        productViewModel.productsArray.append(product)
        productTableView.productViewModel = productViewModel
        productTableView.refreshController.sendActions(for: .valueChanged)
        productViewModel.productsArray.removeAll()
        productTableView.productViewModel = productViewModel
        productTableView.refreshController.sendActions(for: .valueChanged)
    }
    func testCloserCall() {
        productTableView.productViewModel.reloadList()
        productTableView.productViewModel.errorMessage("error")

    }

    func testCanInstantiateViewController() {
        XCTAssertNotNil(productTableView)
    }

    func testTableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(productTableView.tableView)
    }

    func testShouldSetTableViewDataSource() {
        XCTAssertNotNil(productTableView.tableView.dataSource)
    }

    func testConformsToTableViewDataSource() {
        XCTAssert(productTableView.conforms(to: UITableViewDataSource.self))
    }

    func testSetTableViewDelegate() {
        XCTAssertNotNil(productTableView.tableView.delegate)
    }

    func testConformsToTableViewDelegate() {
        XCTAssert(productTableView.conforms(to: UITableViewDelegate.self))
    }

    func testWebclassDelegate() {
        let productViewModel: ProductViewModel = ProductViewModel(title: "viewTitle")
        let productDictionary: NSDictionary = ["title": "Beavers", "description": "Beavers", "imageHref": ""]
        let productEmptyDictionary: NSDictionary = ["title": "", "description": "", "imageHref": ""]
        let resultDictionary: NSDictionary = ["title": "About Canada", "rows": [productDictionary, productEmptyDictionary]]
        XCTAssertNotNil(productViewModel.getResponse(result: resultDictionary))
        XCTAssertNotNil(productViewModel.getErrorResponse(error: "error"))
    }

    func testforProductModelViewInitialization() {
        let productViewModel: ProductViewModel = ProductViewModel(title: "viewTitle")
        let product = ProductModel(name: "title", imageurl: "imageURL", description: "description" )
        productViewModel.productsArray.append(product)
        XCTAssertNotNil(productViewModel)
        XCTAssertNotNil(productViewModel.productsArray)
        XCTAssertTrue(productViewModel.productsArray.count > 0)
        XCTAssertEqual(productViewModel.productTableTitle, "viewTitle")
    }

    func testforProductModelInitialization() {
        let product = ProductModel(name: "title", imageurl: "imageURL", description: "description" )

        XCTAssertNotNil(product)
        XCTAssertEqual(product.productName, "title")
        XCTAssertEqual(product.productDescription, "description")
        XCTAssertEqual(product.productImageurl, "imageURL")

    }

    func testTableViewCellForRowAtIndexPath() {
        let productViewModel: ProductViewModel = ProductViewModel(title: "viewTitle")
        let product = ProductModel(name: "title", imageurl: "imageURL", description: "description" )
        productViewModel.productsArray.append(product)

        productTableView.productViewModel = productViewModel
        let indexPath = NSIndexPath(row: 0, section: 0)
        let cell = (productTableView.tableView(productTableView.tableView, cellForRowAt: indexPath as IndexPath) as? ProductTableViewCell)!
        XCTAssertNotNil(cell)
        let view = cell.contentView
        XCTAssertNotNil(view)
        cell.productName.text = "title"
        cell.productDescription.text = "description"
        XCTAssert(cell.productName.text == product.productName)
        XCTAssert(cell.productDescription.text == product.productDescription)
        cell.productImageView.loadImageUsingCacheWithURLString(product.productImageurl, placeHolder: UIImage(named: "placeholder_for_missing_posters")) { (_) in
        }
        cell.awakeFromNib()
    }

    func testAPIWorking() {
        let webclassObject = WebClass()
        webclassObject.observeReachability()
        webclassObject.eroorResponse(result: "error")
        let productEmptyDictionary: NSDictionary = ["title": "", "description": "", "imageHref": ""]
        webclassObject.mainResponse(result: productEmptyDictionary)
        webclassObject.requestWithURL(requestUrl: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        webclassObject.requestWithURL(requestUrl: "https://facts.json")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

//
//  iOS_Proficiency_POCTests.swift
//  iOS Proficiency POCTests
//
//  Created by prasu on 01/07/20.
//  Copyright © 2020 prasanna. All rights reserved.
//

import XCTest
@testable import iOS_Proficiency_POC

class iOS_Proficiency_POCTests: XCTestCase {

    let productTableView = ProductTableViewController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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

    func testSUT_ShouldSetCollectionViewDelegate() {
        XCTAssertNotNil(productTableView.tableView.delegate)
    }

    func testConformsToTableViewDelegate() {
        XCTAssert(productTableView.conforms(to: UITableViewDelegate.self))
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

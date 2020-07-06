//
//  ProductTableViewController.swift
//  iOS Proficiency POC
//
//  Created by prasu on 01/07/20.
//  Copyright © 2020 prasanna. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController {
    var productViewModel: ProductViewModel = ProductViewModel(title: "")
    let refreshController = UIRefreshControl()
    var indicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()

        //Table view cell regestration with Identifier
        self.tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "productTableViewCell")
        //Make table view cell height flexible
        self.tableView.rowHeight = UITableView.automaticDimension
        // setting up data from view model class
        productViewModel.callingAPItoGetProductDetails()
        self.closureSetUp()
        // View title
        self.navigationItem.title = productViewModel.productTableTitle
        addingActivityIndicator()
        addingRefreshControllerToTableView()
        indicator.startAnimating()
    }

        // MARK: - Refresh controller
    func addingRefreshControllerToTableView() {
        // creating and adding refresh controller
        refreshController.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshController.addTarget(self, action: #selector(self.refreshTableView(_:)), for: .valueChanged)
        tableView.addSubview(refreshController)
    }

    @objc func refreshTableView(_ sender: AnyObject) {
       // Code to refresh table view
       if productViewModel.productsArray.count > 0 {
        self.tableView.reloadData()
        self.navigationItem.title = self.productViewModel.productTableTitle
        self.refreshController.endRefreshing()
        } else {
            self.refreshController.endRefreshing()
        }
    }

    func addingActivityIndicator() {
        indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        indicator.frame = CGRect(x: view.center.x - 50, y: view.center.y - 150, width: 100.0, height: 100.0)
        view.addSubview(indicator)
        indicator.backgroundColor = UIColor.lightGray
        indicator.layer.cornerRadius = 10
        indicator.color = UIColor.white
        indicator.bringSubviewToFront(view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    // Closure initialize to load Data
    func closureSetUp() {
        productViewModel.reloadList = { [weak self] ()  in
            // UI changes in main tread
            DispatchQueue.main.async {
                // reloading the UI with data
                self?.tableView.reloadData()
                self?.navigationItem.title = self?.productViewModel.productTableTitle
                self?.indicator.removeFromSuperview()
            }
        }
        productViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                self?.indicator.removeFromSuperview()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productViewModel.productsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell: ProductTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "productTableViewCell", for: indexPath) as? ProductTableViewCell)!
        if productViewModel.productsArray.count > 0 {
        let product = productViewModel.productsArray[indexPath.row]
        // updating cell data
        cell.productName.text = product.productName
        cell.productDescription.text = "\(String(describing: product.productDescription))"
        if !product.productImageurl.isEmpty {
            DispatchQueue.main.async {
                cell.productImageView.loadImageUsingCacheWithURLString(product.productImageurl, placeHolder: UIImage(named: "placeholder_for_missing_posters")) { (_) in
                    print("No Image")
                }
            }
            }
        }
        return cell
    }
}

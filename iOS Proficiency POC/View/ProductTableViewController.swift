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

    override func viewDidLoad() {
        super.viewDidLoad()

        //Table view cell regestration with Identifier
        self.tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "cell")
        //Make table view cell height flexible
        self.tableView.rowHeight = UITableView.automaticDimension
        // setting up data from view model class
        productViewModel.callingAPItoGetProductDetails()
        self.closureSetUp()
        // View title
        self.navigationItem.title = productViewModel.productTableTitle
    }
    
        // MARK: - Refresh controller
    func addingRefreshControllerToTableView() {
        // creating and adding refresh controller
        refreshController.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshController.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshController)
    }

    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        self.closureSetUp()
    }
    
    // Closure initialize to load Data
    func closureSetUp() {
        productViewModel.reloadList = { [weak self] ()  in
            // UI changes in main tread
            DispatchQueue.main.async {
                // reloading the UI with data
                self?.tableView.reloadData()
                self?.navigationItem.title = self?.productViewModel.productTableTitle
                // Removing refresh controller after updating data
                self?.refreshController.endRefreshing()
            }
        }
        productViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                // Removing refresh controller after getting error
                self?.refreshController.endRefreshing()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        let product = productViewModel.productsArray[indexPath.row]
        // updating cell data
        cell.productName.text = product.productName
        cell.productDescription.text = "\(String(describing: product.productDescription))"
        if !product.productImageurl.isEmpty {
            DispatchQueue.main.async {
            cell.productImageView.downloadImageFrom(withUrl: product.productImageurl) 
            }
        }
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
    }*/

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

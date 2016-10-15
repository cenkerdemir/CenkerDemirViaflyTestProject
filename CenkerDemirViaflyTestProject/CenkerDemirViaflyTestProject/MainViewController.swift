//
//  ViewController.swift
//  CenkerDemirViaflyTestProject
//
//  Created by Cenker Demir on 10/13/16.
//  Copyright © 2016 Cenker Demir. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemsTableView: UITableView!
    let store = Store.sharedInstance
    var itemsList = [Item]()
    var filteredItemList = [Item]()
    var sortingStyle = "ascending"
    var categoryNameToShow = String()
    
    @IBOutlet weak var categoriesButtonForSideBar: UIBarButtonItem!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //create a local array to store the list of the items in the store
        store.getItemsForStore(categoryToGet: categoryNameToShow)
        itemsList = store.items
        
        //assign self to data source
        itemsTableView.dataSource = self
        
        //set up the side bar
        if self.revealViewController() != nil {
            categoriesButtonForSideBar.target = self.revealViewController()
            categoriesButtonForSideBar.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        //searchController.searchBar =
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        itemsTableView.tableHeaderView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //sort button tapped
    @IBAction func sortTapped(_ sender: UIButton) {
        if sortingStyle == "ascending" {
            itemsList.sort(by: { (item1, item2) -> Bool in
                if item1.price == item2.price {
                    return item1.itemName < item2.itemName
                }
                else {
                    return item1.price < item2.price
                }
            })
            sortingStyle = "descending"
        }
        else {
            itemsList.sort(by: { (item1, item2) -> Bool in
                if item1.price == item2.price {
                    return item1.itemName < item2.itemName
                }
                else {
                    return item1.price > item2.price
                }
            })
            sortingStyle = "ascending"
        }
        itemsTableView.reloadData()
    }
    
    // in-stock filtering button tapped
    @IBAction func inStockFilterButtonTapped(_ sender: UIButton) {
        print("in stock filtering button tapped")
        let inStockList = itemsList.filter { (item) -> Bool in
            return item.quantity > 0
        }
        itemsList = inStockList
        itemsTableView.reloadData()
    }
    
    //MARK: - TableView functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredItemList.count
        }
        return itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        var item = Item()
        if searchController.isActive && searchController.searchBar.text != "" {
            item = filteredItemList[indexPath.row]
        }
        else {
            item = itemsList[indexPath.row]
        }
        
        let key = item.itemName
        cell.textLabel?.text = key
        let inStock : String = isItemInStock(quantity: item.quantity) ? "in stock" : "out of stock"
        cell.detailTextLabel?.text = "$" + String(describing: item.price) + "\t\t" + inStock
        cell.detailTextLabel?.textColor = isItemInStock(quantity: item.quantity) ? UIColor.inStockDarkGreen() : UIColor.red
        cell.imageView?.image = UIImage(named: assignImageToCell(itemCategory: item.category))
        return cell
    }
    
    func isItemInStock(quantity: Int) -> Bool {
        return quantity > 0
    }
    
    //helper function to assign images to the cell
    func assignImageToCell(itemCategory: String) -> String {
        var imageName = String()
        switch itemCategory {
        case "Men's":
            imageName = "men.png"
        case "Women's":
            imageName = "women.png"
        case "Outerwear":
            imageName = "outwear.png"
        default:
            imageName = "accessories.png"
        }
        return imageName
    }
    
}


extension MainViewController : UISearchBarDelegate {
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredItemList = itemsList.filter({ (item) -> Bool in
            return item.itemName.lowercased().contains(searchText.lowercased())
        })
        itemsTableView.reloadData()
    }
}


extension MainViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


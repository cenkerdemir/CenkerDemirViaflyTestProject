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
    var sortingStyleAscending : Bool = true
    var inStockOnly : Bool = true
    var categoryNameToShow = String()
    
    @IBOutlet weak var categoriesButtonForSideBar: UIBarButtonItem!
    
    //@IBOutlet weak var searchBar: UISearchBar!
    
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
        
        //set up the search bar and the delegate
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
    @IBAction func sortButtonTapped(_ sender: AnyObject) {
        if sortingStyleAscending == true {
            itemsList.sort(by: { (item1, item2) -> Bool in
                if item1.price == item2.price {
                    return item1.itemName < item2.itemName
                }
                else {
                    return item1.price < item2.price
                }
            })
            sortingStyleAscending = false
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
            sortingStyleAscending = true
        }
        itemsTableView.reloadData()
    }
    
    // in-stock filtering button tapped
    @IBAction func inStockFilterButtonTapped(_ sender: UIBarButtonItem) {
        switch inStockOnly {
        case true:
            let inStockList = itemsList.filter { (item) -> Bool in
                return item.quantity > 0
            }
            itemsList = inStockList
            inStockOnly = false
        case false:
            itemsList = store.items
            inStockOnly = true
        }
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
        let inStockString = item.isItemInStock() ? "in stock" : "out of stock"
        let priceString = String(format: item.price == floor(item.price) ? "%.0f" : "%.2f", item.price)
        cell.detailTextLabel?.text = "$" + priceString + "\t\t" + inStockString
        cell.detailTextLabel?.textColor = item.isItemInStock() ? UIColor.inStockDarkGreen() : UIColor.red
        cell.imageView?.image = UIImage(named: assignImageToCell(itemCategory: item.category))
        return cell
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

//MARK: - MainVC extensions

// MainVC Class extension for the search bar delegate protocol
extension MainViewController : UISearchBarDelegate {
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredItemList = itemsList.filter({ (item) -> Bool in
            return item.itemName.lowercased().contains(searchText.lowercased())
        })
        itemsTableView.reloadData()
    }
}

// MainVC class extension for the search resultsupdating protocol
extension MainViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


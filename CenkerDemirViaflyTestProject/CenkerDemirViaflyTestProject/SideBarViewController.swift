//
//  SideBarTableViewController.swift
//  CenkerDemirViaflyTestProject
//
//  Created by Cenker Demir on 10/14/16.
//  Copyright © 2016 Cenker Demir. All rights reserved.
//

import Foundation

class SideBarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sideBarTableView: UITableView!
    
    let store = Store.sharedInstance
    var menuSelections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assign self to datasource
        sideBarTableView.dataSource = self
        
        //create the menu items array directly from the data file
        menuSelections = store.getCategories()
        // add all items as it is not part of the data file but needed for the side bar menu
        menuSelections.insert("All Items", at: 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSelections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideBarCell", for: indexPath)
        
        cell.textLabel?.text = menuSelections[indexPath.row]
        cell.imageView?.image = UIImage(named: assignImageToCell(itemCategory: menuSelections[indexPath.row]))
        
        return cell
    }
    
    //helper function to assign images to the cell. In a real world application every item would have at least one image member property. Here I wanted to make it looks nice so assigned an image to each category
    func assignImageToCell(itemCategory: String) -> String {
        var imageName = String()
        switch itemCategory {
        case "All Items" :
            imageName = "empty.png"
        case "Women's":
            imageName = "women.png"
        case "Men's":
            imageName = "men.png"
        case "Outerwear":
            imageName = "outwear.png"
        case "Accessories":
            imageName = "accessories.png"
        default:
            imageName = "empty.png"
        }
        return imageName
    }
    
    // we set the category name for the VC in this function so we can request different set of items depending on the user selection from the side bar menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemListSegue" {
            let navigationController = segue.destination
            let destVC = navigationController.childViewControllers.first as! MainViewController
            guard let indexPath : IndexPath = sideBarTableView.indexPathForSelectedRow else {
                print("could not get the index path")
                return
            }
            destVC.categoryNameToShow = menuSelections[indexPath.row]
        }
    }
    
}

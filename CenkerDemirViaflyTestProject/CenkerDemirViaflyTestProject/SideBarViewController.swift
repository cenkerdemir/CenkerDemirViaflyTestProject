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
        menuSelections = store.getCategories()
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
    
    //helper function to assign images to the cell
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "itemListSegue" {
            let navigationController = segue.destination
            let destVC = navigationController.childViewControllers.first as! MainViewController
            guard let indexPath : IndexPath = sideBarTableView.indexPathForSelectedRow else {
                print("could not get the index path")
                return
            }
            destVC.categoryNameToShow = menuSelections[indexPath.row]
            print(menuSelections[indexPath.row])
        }
        
    }
    
}

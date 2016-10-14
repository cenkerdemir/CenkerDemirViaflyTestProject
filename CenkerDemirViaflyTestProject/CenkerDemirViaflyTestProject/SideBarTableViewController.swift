//
//  SideBarTableViewController.swift
//  CenkerDemirViaflyTestProject
//
//  Created by Cenker Demir on 10/14/16.
//  Copyright © 2016 Cenker Demir. All rights reserved.
//

import Foundation

class SideBarTableViewController: UITableViewController {
    
    let menuSelections = ["", "Inventory", "Women's","Men's","Outerwear","Accessories"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSelections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideBarCell", for: indexPath)
        
        cell.textLabel?.text = menuSelections[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

//
//  Store.swift
//  CenkerDemirViaflyTestProject
//
//  Created by Cenker Demir on 10/13/16.
//  Copyright © 2016 Cenker Demir. All rights reserved.
//

import Foundation

class Store {
    static let sharedInstance = Store()
    
    var items = [Item]()
    var categories = [String]()
    
    // function to create a store array that has the store items in it, request of the items array comes with a category. it is either empty or a valid string
    func getItemsForStore (categoryToGet: String) {
        items.removeAll()
        guard let filePath = Bundle.main.path(forResource: "StoreInventory", ofType: "json") else {
            print("\n\n\nerror occured while looking for the json file...\n\n\n")
            return
        }
        
        let localURL = URL(fileURLWithPath: filePath)
        
        do {
            let jsonData = try Data(contentsOf: localURL, options: [])
            let itemsArray = try JSONSerialization.jsonObject(with:jsonData, options: []) as! [NSDictionary]
            
            let queue = DispatchQueue.init(label: "com.Cenker.Demir.CenkerDemirViaflyTestProject")
            for eachItem in itemsArray {
                queue.sync(execute: {
                    let item = Item()
                    item.itemName = eachItem.value(forKey: "Item") as! String
                    item.systemID = eachItem.value(forKey: "System ID") as! Int
                    item.category = eachItem.value(forKey: "Category") as! String
                    item.codeUPC = eachItem.value(forKey: "UPC") as! Int
                    item.quantity = eachItem.value(forKey: "Qty.") as! Int
                    let priceAsAString = eachItem.value(forKey: "Price") as! String
                    if let price = Double(priceAsAString.replacingOccurrences(of: "$", with: "")) {
                        item.price = price
                    }
                    self.items.append(item)
                })
            }
            filterItems(categoryToGet: categoryToGet)
        }
        catch {
            print("could not get the data from the file")
        }
    }
    
    // function to filter items based on the category.
    func filterItems(categoryToGet: String) {
        if categoryToGet != "" && getCategories().contains(categoryToGet) == true {
            let filteredItems = items.filter({ (item) -> Bool in
                return item.category == categoryToGet
            })
            items = filteredItems
        }
    }
    
    // function to get the categories from the data file
    func getCategories() -> [String] {
        var categoryArray = [String]()
        for item in items {
            if !categoryArray.contains(item.category) {
                categoryArray.append(item.category)
            }
        }
        return categoryArray
    }
}

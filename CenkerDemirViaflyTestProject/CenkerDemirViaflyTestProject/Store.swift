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
    
    func getItemsForStore () {
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
                queue.async(execute: { 
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
        }
        catch {
            print("could not get the data from the file")
        }
//      uncomment to print out the items in the store
//      for item in items {
//          print(item.description())
//      }
    }
    
    func getCategories() -> [String] {
        var categorySet = Set<String>()
        var categoryArray = ["All Items"]
        for item in items {
            categorySet.insert(item.category)
        }
        categoryArray.append(contentsOf: categorySet)
        return categoryArray
    }
}

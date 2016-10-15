//
//  Item.swift
//  CenkerDemirViaflyTestProject
//
//  Created by Cenker Demir on 10/13/16.
//  Copyright © 2016 Cenker Demir. All rights reserved.
//

import Foundation

class Item {
    var systemID = Int()
    var codeUPC = Int()
    var itemName = String()
    var quantity = Int()
    var price = Double()
    var category = String()
    
    //for printing purposes, makes it easy to read
    func description() -> String {
        return "\(systemID) - \(codeUPC) - \(itemName) - \(quantity) - \(price) - \(category)"
    }
    
    //each item can tell you if it is in stock or not.
    func isItemInStock() -> Bool {
        return quantity > 0
    }
}

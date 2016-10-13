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
    
    public func description() -> String {
        return "\(systemID) - \(codeUPC) - \(itemName) - \(quantity) - \(price) - \(category)"
    }
}

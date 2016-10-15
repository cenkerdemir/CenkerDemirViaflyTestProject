//
//  AppDelegate.swift
//  CenkerDemirViaflyTestProject
//
//  Created by Cenker Demir on 10/13/16.
//  Copyright © 2016 Cenker Demir. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //setting up colors for the navigation bar and the search bar so they look nice :-)
        UINavigationBar.appearance().barTintColor = UIColor.viaflyBlue()
        UISearchBar.appearance().barTintColor = UIColor.viaflyBlue()
        UISearchBar.appearance().tintColor = UIColor.white
        
        //get the initial store items to show on the main view
        let store = Store.sharedInstance
        store.getItemsForStore(categoryToGet: "")
        
        return true
    }

}

// a UIColor extension for extra colors
extension UIColor {
    
    static func viaflyBlue() -> UIColor {
        return UIColor(red: 63.0/255.0, green: 143.0/255.0, blue: 168.0/255.0, alpha: 1.0)
    }
    
    static func inStockDarkGreen() -> UIColor {
        return UIColor(red: 12.0/255.0, green: 140.0/255.0, blue: 91.0/255.0, alpha: 1.0)
    }

}


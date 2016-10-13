//
//  ViewController.swift
//  CenkerDemirViaflyTestProject
//
//  Created by Cenker Demir on 10/13/16.
//  Copyright © 2016 Cenker Demir. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var fullItemList: UITableView!
    let store = Store.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        fullItemList.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let item : Item = store.items[indexPath.row]
        let key = item.itemName
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = "$" + String(describing: item.price)
        // below code can be uncommented to show images
        switch item.category {
        case "Men's":
            cell.imageView?.image = UIImage(named: "men.png")
            //cell.backgroundColor = UIColor.cyan
        case "Women's":
            cell.imageView?.image = UIImage(named: "women.png")
            //cell.backgroundColor = UIColor.red
        case "Outerwear":
            cell.imageView?.image = UIImage(named: "outwear.png")
            //cell.backgroundColor = UIColor.green
        default:
            cell.imageView?.image = UIImage(named: "accessories.png")
            //cell.backgroundColor = UIColor.gray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


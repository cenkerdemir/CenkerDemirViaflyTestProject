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
    
    let arr = ["ffefejhg jhgjhgjhg jhgjhgjhg jhgjhgj hgjhgjhg", "dfwfwef", "efqwfdwqdew" , "efqwfqwf"]
    let dict = ["ffefejhg jhgjhgjhg jhgjhgjhg jhgjhgj hgjhgjhg" : 1, "dfwfwef" : 2, "efqwfdwqdew" : 3, "efqwfqwf" : 4]
    
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
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let key = arr[indexPath.row] as String
        cell.textLabel?.text = key
        
        if let value = dict[key] {
            cell.detailTextLabel?.text = "$" + String(describing: value)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


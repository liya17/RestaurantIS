//
//  ViewController.swift
//  RestaurantIS
//
//  Created by Liya Wu-17 on 1/16/17.
//  Copyright © 2017 chapin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return  1
//    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath as IndexPath) 
//        
//        let row = indexPath.row
//        return cell
//    }


}


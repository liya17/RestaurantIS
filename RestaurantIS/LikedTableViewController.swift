//
//  LikedTableViewController.swift
//  RestaurantIS
//
//  Created by Liya Wu-17 on 2/6/17.
//  Copyright © 2017 chapin. All rights reserved.
//

import UIKit

class LikedTableViewController: UITableViewController {

    var otherArray = [String]()
    
    var oImageArray = [UIImage]()
    
    var cuisineArray = [String]()
    
    var valueToPass:String!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("otherArray: \(otherArray)")
        //print("image array: \(oImageArray)")
//        for i in 0...otherArray.count-1 {
//            // for (restaurant) in self.restaurantNamesArray {
//
//        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //self.tableView(UITableView, numberOfRowsInSection: 0)
        
        
    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "LikedCell", for: indexPath as IndexPath) as! LikedTableViewCell //1
//        
//        cell.nameLabel.text = "Hello World"
//        
//        return cell
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return otherArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikedCell", for: indexPath) as? LikedTableViewCell

        // Configure the cell...
        let row = indexPath.row
        cell?.nameLabel.text = otherArray[row]
        cell?.typeLabel.text = cuisineArray[row]
        
//        let destinationVC = InfoViewController()
//        destinationVC.name.text = otherArray[row]
        // Let's assume that the segue name is called playerSegue
        // This will perform the segue and pre-load the variable for you to use
        //destinationVC.performSegue(withIdentifier: "displayRestaurant", sender: self)
        
        cell?.chosenImageView?.image = oImageArray[row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPathVal: NSIndexPath = tableView.indexPathForSelectedRow! as NSIndexPath

        let currentCell = tableView.cellForRow(at: indexPathVal as IndexPath) as! LikedTableViewCell!;
        
        //Storing the data to a string from the selected cell
        valueToPass = currentCell?.nameLabel.text!
        print(valueToPass)
        //Now here I am performing the segue action after cell selection to the other view controller by using the segue Identifier Name
        
        //super.prepareForSegue(segue, sender: sender)
        performSegue(withIdentifier: "displayRestaurant", sender: indexPathVal)
        self.performSegue(withIdentifier: "displayRestaurant", sender: self)


    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //Here i am checking the Segue and Saving the data to an array on the next view Controller also sending it to the next view COntroller
        if segue.identifier == "displayRestaurant"{
            //Creating an object of the second View controller
            let controller = segue.destination as! InfoViewController
            //Sending the data here
            controller.name.text = valueToPass
            
            print("hello \(valueToPass)")
            
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

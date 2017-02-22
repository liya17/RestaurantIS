////
////  PopoverViewController.swift
////  RestaurantIS
////
////  Created by Liya Wu-17 on 2/16/17.
////  Copyright © 2017 chapin. All rights reserved.
////
//
//import UIKit
//
//class PopoverViewController: UIViewController, UIPopoverPresentationControllerDelegate {
//    
//    @IBOutlet weak var but: UIButton!
//    
//    
//    @IBAction func butTapped(_ sender: Any) {
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "PopoverViewController") as! UIViewController
//        vc.modalPresentationStyle = UIModalPresentationStyle.popover
//        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
//        popover.barButtonItem = sender
//        present(vc, animated: true, completion:nil)
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

//
//  RestaurantViewController.swift
//  RestaurantIS
//
//  Created by Liya Wu-17 on 1/17/17.
//  Copyright © 2017 chapin. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

    var score: Int!
    var done: Bool = false
    
    var restaurantNamesArray = [String]()
    var restaurantCuisineArray = [String]()
    var restaurantPriceArray  = [String]()
    
    @IBOutlet weak var scoreView: UITextView!
    
    @IBAction func likePressed(_ sender: Any) {
        print("This button is pressed")
        self.determineJudgement(true)
        self.score = self.score + 1
        self.scoreView.text = "Liked: \(self.score)"
        self.determineScore()
        
    }
    
    @IBAction func dislikePressed(_ sender: Any) {
        print("This button is pressed")
        self.determineJudgement(false)
    }
    
    var restaurantViews: [RestaurantView] = []
    var currentRestaurantView: RestaurantView!
    
    // Create a variable called data.  (String, Bool) -> Statement, Answer
    
//    var data: [(String)] = [
//        (""),
//        (""),
//    ]
    
    //var restaurantList: [(String,Bool)] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    // ------------------------------START ZOMATO API ---------------------------------------
        let zomatoKey = "19f8f67d41d482999c498e28f05a22d1"
        let centerLatitude = 40.773988, centerLongitude = -73.946084
        let urlString = "https://developers.zomato.com/api/v2.1/search?&lat=\(centerLatitude)&lon=\(centerLongitude)";
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(zomatoKey, forHTTPHeaderField: "user_key")
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        if let restaurants = json["restaurants"] as? [NSDictionary] {
                            for rest in restaurants {
                                let restaurant = rest["restaurant"] as! NSDictionary
                                // Load data into local variables
                                // print(restaurant["name"] as? String ?? "null")
                                
                                self.restaurantNamesArray.append(restaurant["name"] as? String ?? "null")
 
                                self.restaurantCuisineArray.append(restaurant["cuisines"] as? String ?? "null")

                            }
                            // Display first restaurant
                            //print("Data loaded, proceeding")
                            //self.data = self.restaurantNamesArray
                            //print("self.data = self.restaurantNamesArray")
                            DispatchQueue.main.async {
                                self.panels()
                            }
                        }
                    }
                }
                catch {}
            }
        })
        
        task.resume()
    // -----------------------------------END ZOMATO API------------------------------------
    }

    func panels() {
        print("self.panels called")
        // Start with a 0 score
        score = 0
        
        //error in here
        for (restaurant) in self.restaurantNamesArray {
            // print(restaurant)
            //for each question and answer, create this view
            //print(restaurant)
            currentRestaurantView = RestaurantView(
                frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 50, height: self.view.frame.width),
                restaurant: restaurant,
                center: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 3)
            )
            self.restaurantViews.append(currentRestaurantView)
        }
        
        //for all the restaurantViews add them to the panel
        for restaurantView in self.restaurantViews {
            self.view.addSubview(restaurantView)
        }
        
        // Add Pan Gesture Recognizer
        let pan = UIPanGestureRecognizer(target: self, action: #selector(RestaurantViewController.handlePan(_:)))
        self.view.addGestureRecognizer(pan)
    }
    
    //when the answer is picked...
    func determineJudgement(_ answer: Bool) {
        
        // If its the right answer, set the score
//        if self.currentRestaurantView.answer == answer && !self.done{
//            self.score = self.score + 1
//            self.scoreView.text = "Liked: \(self.score)" //adding text to text field
//        }
        
        // Run the swipe animation
        self.currentRestaurantView.swipe(answer)
        
        // Handle when we have no more matches
        self.restaurantViews.remove(at: self.restaurantViews.count - 1)
        
        //if out of questions make another restaurant view and say no more restaurants
        if self.restaurantViews.count - 1 < 0 {
            var noMoreView = RestaurantView(
                frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 50, height: self.view.frame.width),
                restaurant: "No More restaurants :(",
                //answer: false,
                center: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 3)
            )
            self.restaurantViews.append(noMoreView)
            self.view.addSubview(noMoreView)
            self.done = true
            return
        }
        
        // Set the new current question to the next one
        self.currentRestaurantView = self.restaurantViews.last!
        
    }
    
    func transferSegue() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "likedView") as! ViewController
        self.present(vc, animated: true, completion: nil)
        //vc.tableViewCell.chosenNameLabel.text = "hello"
    }
    
    func determineScore(){
        if self.score%3 == 0{
            let refreshAlert = UIAlertController(title: "You've liked 3 Restaurants", message: "Keep Swiping?", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                print("Segue to next view controller")
                self.transferSegue()
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Keep swiping")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        // Is this gesture state finished??
        if gesture.state == UIGestureRecognizerState.ended {
            // Determine if we need to swipe off or return to center - did the user lift his/her finger up? if so where?
            let location = gesture.location(in: self.view)
            //did they move their finger enough
            if self.currentRestaurantView.center.x / self.view.bounds.maxX > 0.8 {
                self.determineJudgement(true)
                self.score = self.score + 1
                self.scoreView.text = "Liked: \(self.score)"
                self.determineScore()
                var currentName = self.currentRestaurantView.restaurantLabel.text
                
               // self.currentRestaurantView.restaurantLabel
                //self.transferInfo(info: currentName!)
                //self.transferSegue()
            }
            else if self.currentRestaurantView.center.x / self.view.bounds.maxX < 0.2 {
                self.determineJudgement(false)
            }
            else {
                self.currentRestaurantView.returnToCenter()
            }
        }
        let translation = gesture.translation(in: self.currentRestaurantView)
        //as the user is moving their finger, move the image with it
        self.currentRestaurantView.center = CGPoint(x: self.currentRestaurantView!.center.x + translation.x, y: self.currentRestaurantView!.center.y + translation.y)
        gesture.setTranslation(CGPoint.zero, in: self.view) //reset
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

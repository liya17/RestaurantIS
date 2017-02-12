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
    var restaurantPriceArray  = [Double]()
    var restaurantImageArray = [String]()
    
    @IBOutlet weak var scoreView: UITextView!
    
    @IBAction func likePressed(_ sender: Any) {
        print("This button is pressed")
        self.determineJudgement(true)
        self.score = self.score + 1
//self.scoreView.text = "Liked: \(self.score)"
        self.determineScore()
        
    }
    
    @IBAction func dislikePressed(_ sender: Any) {
        print("This button is pressed")
        self.determineJudgement(false)
    }
    
    var restaurantViews: [RestaurantView] = []
    var currentRestaurantView: RestaurantView!
    
    //var likedArray: [RestaurantView] = []
    var likedArray: [String] = []
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
        let centerLatitude = 40.7905, centerLongitude = -73.9713
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
                                self.restaurantPriceArray.append(restaurant["average_cost_for_two"] as? Double ?? 0)
                                self.restaurantImageArray.append(restaurant["featured_image"] as? String ?? "null")

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
        for i in 0...restaurantNamesArray.count-1 {
        // for (restaurant) in self.restaurantNamesArray {
            let restaurant = restaurantNamesArray[i]
            let cuisine = restaurantCuisineArray[i]
            let price = restaurantPriceArray[i]
            let image = restaurantImageArray[i]
            
            // print(restaurant)
            //for each question and answer, create this view
            //print(restaurant)
            currentRestaurantView = RestaurantView(
                frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 50, height: self.view.frame.width),
                restaurant: restaurant,
                image: image,
                cuisine: cuisine,
                price: price,
                center: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 3)
            )
            self.restaurantViews.append(currentRestaurantView)
            
            //self.likedArray.append(restaurant)
            
            //self.addToArray(String: restaurant)
        }
        
        //for all the restaurantViews add them to the panel
        for restaurantView in self.restaurantViews {
            self.view.addSubview(restaurantView)
        }
        /**
        for (cuisine) in self.restaurantCuisineArray {
            // print(cuisine)
            //for each question and answer, create this view
            //print(cuisine)
            currentRestaurantView = RestaurantView(
                frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 50, height: self.view.frame.width),
                restaurant: cuisine,
                cuisine: cuisine,
                center: CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 3)
            )
            self.restaurantViews.append(currentRestaurantView)
        }
        
        //for all the restaurantViews add them to the panel
        for restaurantView in self.restaurantViews {
            self.view.addSubview(restaurantView)
        } **/
        
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
                image: "None",
                cuisine: "None",
                price: 0,
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

    var arr: [String] = []
    func transferSegue() {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "likedView") as! LikedTableViewController
//        self.present(vc, animated: true, completion: nil)
        
        //var newArray = vc.otherArray
        
        for i in 0...likedArray.count-1 {
            arr.append(likedArray[i])
        }
//        print(vc.otherArray)
        print(arr)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "likedView") as! LikedTableViewController
        self.present(vc, animated: true, completion: nil)
        
        
        //print(likedArray)
        //let cell = self.storyboard?.instantiateTableViewControllerCell(withIdentifier: "LikedCell") as! LikedTableViewCell
        
    }
    
    func transferInfo() {
        
    }
    
    func determineScore(){
        if self.score%3 == 0{
            let refreshAlert = UIAlertController(title: "You've liked 3 Restaurants", message: "Keep Swiping?", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
                print("Segue to next view controller")
                self.transferSegue()
                
                //self.likedArray.append(/*self.currentRestaurantView.*/restaurant)
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Keep swiping")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    func addToArray(String: String){
        self.likedArray.append(String)
        //print(likedArray)
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
                //self.scoreView.text = "Liked: \(self.score)"
                self.determineScore()
                //var currentName = self.currentRestaurantView.restaurantLabel.text as String!
                print (self.currentRestaurantView.restaurantLabel.text!)
                //print(self.currentRestaurantView.restaurantLabel.text)
                likedArray.append(self.currentRestaurantView.restaurantLabel.text!)
                //print(likedArray)
                //self.addToArray(String: currentName!)
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

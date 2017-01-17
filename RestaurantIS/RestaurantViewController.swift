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
    
    @IBOutlet weak var scoreView: UITextView!
    
    @IBAction func likePressed(_ sender: Any) {
        print("This button is pressed")
        self.determineJudgement(true)
    }
    
    @IBAction func dislikePressed(_ sender: Any) {
        print("This button is pressed")
        self.determineJudgement(false)
    }
    
    var restaurantViews: [RestaurantView] = []
    var currentRestaurantView: RestaurantView!

    
    // Create a variable called data.  (String, Bool) -> Statement, Answer
    var data: [(String, Bool)] = [
        ("The color orange is named after the fruit.", true),
        ("You can legally drink alcohol while driving in mississippi", true),
        ("George Washington has wooden teeth.", false),
        ("It is illegal to pee in the ocean in Portugal", true),
        ("The space between your eyebrows is called the rasceta.", false),
        ("You can lead a cow down stairs but not upstairs.", false),
        ("The sky is blue.", true)
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start with a 0 score
        score = 0
        
        for (restaurant, answer) in self.data {
            //for each question and answer, create this view
            currentRestaurantView = RestaurantView(
                frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 50, height: self.view.frame.width - 50),
                question: restaurant,
                answer: answer,
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
        if self.currentRestaurantView.answer == answer && !self.done{
            self.score = self.score + 1
            self.scoreView.text = "Score: \(self.score)" //adding text to text field
        }
        
        // Run the swipe animation
        self.currentRestaurantView.swipe(answer)
        
        // Handle when we have no more matches
        self.restaurantViews.remove(at: self.restaurantViews.count - 1)
        
        //if out of questions make another restaurant view and say no more restaurants
        if self.restaurantViews.count - 1 < 0 {
            var noMoreView = RestaurantView(
                frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 50, height: self.view.frame.width - 50),
                question: "No More Questions :(",
                answer: false,
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
    
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        // Is this gesture state finished??
        if gesture.state == UIGestureRecognizerState.ended {
            // Determine if we need to swipe off or return to center - did the user lift his/her finger up? if so where?
            let location = gesture.location(in: self.view)
            //did they move their finger enough
            if self.currentRestaurantView.center.x / self.view.bounds.maxX > 0.8 {
                self.determineJudgement(true)
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

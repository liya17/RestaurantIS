//
//  RestaurantView.swift
//  RestaurantIS
//
//  Created by Liya Wu-17 on 1/17/17.
//  Copyright © 2017 chapin. All rights reserved.
//

import UIKit

class RestaurantView: UIView {

    let imageMarginSpace: CGFloat = 5.0
    var futura = UIFont(name: "Futura", size: CGFloat(36.0))
    var restaurantView: UITextView!
    var animator: UIDynamicAnimator!
    var originalCenter: CGPoint!
    var restaurant: String!
    var answer: Bool!

    var restaurantLabel: UILabel!
    var cuisineLabel: UILabel!
    //constructor for object
    //what is going to happen in the panel
    init(frame: CGRect, restaurant: String, /*answer: Bool,*/ center: CGPoint) {
        // Gives all the stuff Apple provides
        super.init(frame: frame)
        self.center = center
        //self.answer = answer
        self.restaurant = restaurant
        //self.restCuisine = restCuisine
       
        // Set the background to white
        self.backgroundColor = UIColor.white
        self.layer.shouldRasterize = true
        
        // Original -- if user does not swipe the image fully the image will go back to the original center
        self.originalCenter = center
        
        // Apple thing. For physics
        animator = UIDynamicAnimator(referenceView: self)
        // Question
        
        //------------------------Start Text View------------------------------------
        restaurantView = UITextView()
        restaurantView.backgroundColor = UIColor(red: 232.0/255.0, green: 186.0/255.0, blue: 188/255.0, alpha: 1.0) //background color for text - red
        
        //fit within the frame
        restaurantView.frame = CGRect(
            x: 0.0 + self.imageMarginSpace,
            y: 0.0 + self.imageMarginSpace,
            width: self.frame.width - (2 * self.imageMarginSpace),
            height: self.frame.height - (2 * self.imageMarginSpace)
            ).integral
        
        restaurantView.layer.shouldRasterize = true
        self.addSubview(restaurantView) //put text on the panel - layer
        self.applyShadow() //apply shadow (function below)
        //--------------------------End Image View------------------------------------
        
        
        //------------------------Start Restaurant Label------------------------------------
        restaurantLabel = UILabel()
        //restaurantLabel.text = "restaurant label"
        restaurantLabel.text = restaurant
        //restaurantLabel.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) //background color for text - red
        
        restaurantLabel.frame = CGRect(
            x: 5.0 + self.imageMarginSpace,
            y: (self.frame.height - self.imageMarginSpace) - (self.frame.height - (60 * self.imageMarginSpace)),
            width: self.frame.width /*- (30 * self.imageMarginSpace)*/,
            height: self.frame.height - (70 * self.imageMarginSpace)
            ).integral
        
        restaurantLabel.font = self.futura //font
        restaurantLabel.font = restaurantLabel.font.withSize(20)
        restaurantLabel.textColor = UIColor.black //text color
        restaurantLabel.layer.shouldRasterize = true
        self.addSubview(restaurantLabel) //put text on the panel - layer
        self.applyShadow() //apply shadow (function below)
        //-------------------------End Restaurant Label------------------------------------
        
        //-------------------------Start Cuisine Label------------------------------------
        cuisineLabel = UILabel()
        cuisineLabel.text = "hey"
        
        cuisineLabel.frame = CGRect(
            x: 5.0 + self.imageMarginSpace,
            y: (self.frame.height - self.imageMarginSpace) - (self.frame.height - (60 * self.imageMarginSpace)),
            width: self.frame.width /*- (30 * self.imageMarginSpace)*/,
            height: self.frame.height - (58 * self.imageMarginSpace)
            ).integral
        
        cuisineLabel.font = self.futura //font
        cuisineLabel.font = cuisineLabel.font.withSize(20)
        cuisineLabel.textColor = UIColor.black //text color
        cuisineLabel.layer.shouldRasterize = true
        self.addSubview(cuisineLabel) //put text on the panel - layer
        self.applyShadow() //apply shadow (function below)

    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    //apply shadow to image
    func applyShadow() {
        self.layer.cornerRadius = 6.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: -3)
    }
    
    //swipe restaurant off the screen
    func swipe(_ answer: Bool) { //Bool defines what type the answer is
        animator.removeAllBehaviors()
        
        // If the answer is false, Move to the left
        // Else if the answer is true, move to the right
        let gravityX = answer ? 0.5 : -0.5
        let magnitude = answer ? 20.0 : -20.0
        let gravityBehavior:UIGravityBehavior = UIGravityBehavior(items: [self])
        gravityBehavior.gravityDirection = CGVector(dx: CGFloat(gravityX), dy: 0)
        animator.addBehavior(gravityBehavior)
        
        let pushBehavior:UIPushBehavior = UIPushBehavior(items: [self], mode: UIPushBehaviorMode.instantaneous)
        pushBehavior.magnitude = CGFloat(magnitude)
        animator.addBehavior(pushBehavior)
        
    }
    
    //if the user does to swipe the image fully, the image will go back to the center
    func returnToCenter() {
        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .allowUserInteraction, animations: {
            self.center = self.originalCenter
        }, completion: { finished in
            print("Finished Animation")}
        )
        
    }
}

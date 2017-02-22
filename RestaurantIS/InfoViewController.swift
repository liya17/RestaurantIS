//
//  InfoViewController.swift
//  RestaurantIS
//
//  Created by Liya Wu-17 on 2/16/17.
//  Copyright © 2017 chapin. All rights reserved.
//

import UIKit
import MapKit

class InfoViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var menu: UIButton!
    
    @IBOutlet weak var website: UIButton!
    
    @IBOutlet weak var reviews: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialLocation = CLLocation(latitude: 40.7740, longitude: -73.9461)
        
        centerMapOnLocation(location: initialLocation)
        
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

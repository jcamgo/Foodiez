//
//  NearbyViewController.swift
//  Foodiez
//
//  Created by jonathan orellana on 10/13/17.
//  Copyright © 2017 jonathan orellana. All rights reserved.
//

import UIKit
import CloudKit
import CoreLocation

class NearbyViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {

    var menuItems = [MenuItem]()
    
    @IBOutlet weak var nearbyTableView: UITableView!
    
    var foodReviewsArrayofDictionaries = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearbyTableView.delegate = self
        nearbyTableView.dataSource = self
    }

    // MARK: - TableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "NearbyTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NearbyTableViewCell else {
            fatalError("The dequed cell id not an instance of NearbyTableViewCell.")
        }
        
        let menuItem = menuItems[indexPath.row]
        
        cell.foodNameLabel.text = menuItem.name
        cell.photImageView.image = menuItem.photo
        //cell.restaurantNameLabel.text = menuItem.restaurant
        cell.ratingControl.rating = menuItem.rating
        
        return cell
    }
}

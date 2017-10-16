//
//  NearbyViewController.swift
//  Foodiez
//
//  Created by jonathan orellana on 10/13/17.
//  Copyright © 2017 jonathan orellana. All rights reserved.
//

import UIKit
import CloudKit

class NearbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nearbyTableView: UITableView!
    
    var foodReviewsArrayofDictionaries = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearbyTableView.delegate = self
        nearbyTableView.dataSource = self
    }

    // MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Le
        
    }
}

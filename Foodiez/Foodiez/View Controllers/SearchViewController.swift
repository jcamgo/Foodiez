//
//  SearchViewController.swift
//  Foodiez
//
//  Created by jonathan orellana on 10/10/17.
//  Copyright © 2017 jonathan orellana. All rights reserved.
//

import UIKit
import GooglePlaces

class SearchViewController: UIViewController, CLLocationManagerDelegate {

    var placesClient: GMSPlacesClient!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        placesClient = GMSPlacesClient.shared()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Location Access Disabled", message: "In order to bring up results we need your location", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: GOOGLE AUTO COMPLETE DELEGATE
    
    @IBAction func openSearchPlace(_ sender: UIBarButtonItem) {
        // placeAutoComplete()
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print(error)
                return
            } else {
                if let placeLikelihoodList = placeLikelihoodList {
                    for likeliHood in placeLikelihoodList.likelihoods {
                        let place = likeliHood.place
                        print(place)
                    }
                }
            }
            
        })
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.autocompleteFilter?.type = .establishment
        autoCompleteController.delegate = self
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
}

extension SearchViewController: GMSAutocompleteViewControllerDelegate {
    
    // Called when a place has been selected from the available autocomplete predictions
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Called when a non-retryable error occurred when retrieving autocomplete predictions or place
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }
    
    // Called when cancel button is tapped
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}














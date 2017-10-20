//
//  SearchViewController.swift
//  Foodiez
//
//  Created by jonathan orellana on 10/10/17.
//  Copyright © 2017 jonathan orellana. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class SearchViewController: UIViewController {
    
    var autoCompleteController = GMSAutocompleteViewController()
    var placesClient = GMSPlacesClient()
    var mapView: GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = GMSMapView()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        // Present the Autocomplete view controller when the button is pressed.
        present(autoCompleteController, animated: true, completion: nil)
        //placeAutoComplete()
    }
}

extension SearchViewController: GMSAutocompleteViewControllerDelegate {

    // Handle the users selection
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }

    // User canceled the operation
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }

    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    func placeAutoComplete() {
        guard let mapView = mapView else { return }
        let visibleRegion = mapView.projection.visibleRegion()
        let bounds = GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.nearRight)

        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        placesClient.autocompleteQuery("Salt Lake City", bounds: bounds, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let results = results {
                for result in results {
                    print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                }
            }
        })
    }
}













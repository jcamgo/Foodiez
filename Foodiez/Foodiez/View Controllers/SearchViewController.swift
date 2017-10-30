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
import CoreLocation

class SearchViewController: UIViewController {
    
    var autoCompleteController = GMSAutocompleteViewController()
    var placesClient = GMSPlacesClient()
    var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    // The currently selected place.
    var selectedPlace: GMSPlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
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

extension SearchViewController: CLLocationManagerDelegate {
    
    // Handle the incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView?.animate(to: camera)
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}















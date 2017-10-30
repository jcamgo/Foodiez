//
//  AppDelegate.swift
//  Foodiez
//
//  Created by jonathan orellana on 10/9/17.
//  Copyright © 2017 jonathan orellana. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GMSPlacesClient.provideAPIKey("AIzaSyCG8ldzWpklin6tsIQzvkn2rCVKBzOj0CQ")
        GMSServices.provideAPIKey("AIzaSyCG8ldzWpklin6tsIQzvkn2rCVKBzOj0CQ")
        return true
    }

}


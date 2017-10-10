//
//  MenuItem.swift
//  Foodiez
//
//  Created by jonathan orellana on 10/10/17.
//  Copyright © 2017 jonathan orellana. All rights reserved.
//

import UIKit
import CloudKit

struct MenuItem {
    
    let recordID: CKRecordID
    let restaurant: CKReference
    let name: String
    var photo: UIImage
    
}

// MARK: - CloudKit

extension MenuItem {
    
    static let restaurantKey = "restaurant"
    static let nameKey = "name"
    static var photoKey = "photo"
    static let recordType = "MenuItem"
    
    init?(record: CKRecord) {
        guard let restaurant = record[MenuItem.restaurantKey] as? CKReference,
            let name = record[MenuItem.nameKey] as? String,
            let photo = record[MenuItem.photoKey] as? UIImage else { return nil }
        
        self.recordID = record.recordID
        self.restaurant = restaurant
        self.name = name
        self.photo = photo
    }
    
    var CKRepresentation: CKRecord {
        let record = CKRecord(recordType: MenuItem.recordType, recordID: recordID)
        
        record.setValue(restaurant, forKey: MenuItem.restaurantKey)
        record.setValue(name, forKey: MenuItem.nameKey)
        record.setValue(photo, forKey: MenuItem.photoKey)
        
        return record
    }
}

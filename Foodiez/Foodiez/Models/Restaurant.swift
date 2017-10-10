//
//  Restaurant.swift
//  Foodiez
//
//  Created by jonathan orellana on 10/10/17.
//  Copyright © 2017 jonathan orellana. All rights reserved.
//

import Foundation
import CloudKit

struct Restaurant {
    
    let recordID: CKRecordID
    let name: String
    let address: String
    
}

// MARK: - CloudKit

extension Restaurant {
    
    static let nameKey = "name"
    static let addressKey = "address"
    static let recordType = "Restaurant"
    
    init?(record: CKRecord) {
        guard let name = record[Restaurant.nameKey] as? String,
            let address = record[Restaurant.addressKey] as? String else { return nil }
        
        self.recordID = record.recordID
        self.name = name
        self.address = address
    }
    
    var CKRepresentation: CKRecord {
        let record = CKRecord(recordType: Restaurant.recordType, recordID: recordID)
        
        record.setValue(name, forKey: Restaurant.nameKey)
        record.setValue(address, forKey: Restaurant.addressKey)
        
        return record
    }
}

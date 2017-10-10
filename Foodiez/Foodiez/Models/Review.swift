//
//  Review.swift
//  Foodiez
//
//  Created by jonathan orellana on 10/10/17.
//  Copyright © 2017 jonathan orellana. All rights reserved.
//

import Foundation
import CloudKit

struct Review {
    
    let recordID: CKRecordID
    let summary: String
    let user: CKReference
    let food: CKReference
    let timestamp: Date
    
}

extension Review {
    
    static let summaryKey = "summary"
    static let userKey = "user"
    static let foodKey = "food"
    static let timestampKey = "timestamp"
    static let recordType = "Review"
    
    init?(record: CKRecord) {
        guard let summary = record[Review.summaryKey] as? String,
            let user = record[Review.userKey] as? CKReference,
            let food = record[Review.foodKey] as? CKReference,
            let timestamp = record[Review.timestampKey] as? Date else { return nil }
        
        self.recordID = record.recordID
        self.summary = summary
        self.user = user
        self.food = food
        self.timestamp = timestamp
    }
    
    var CKRepresentation: CKRecord {
        let record = CKRecord(recordType: Review.recordType, recordID: recordID)
    }
}

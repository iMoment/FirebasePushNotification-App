//
//  FIRDatabaseService.swift
//  FirebaseNotifications
//
//  Created by Stanley Pan on 22/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import Foundation
import Firebase

enum FIRDatabaseReference: String {
    case products = "products"
}

class FIRDatabaseService {
    
    private init() {}
    static let sharedInstance = FIRDatabaseService()
    
    //  MARK: Database constantly references a url endpoint
    func reference(_ databaseReference: FIRDatabaseReference) -> DatabaseReference {
        return Database.database().reference().child(databaseReference.rawValue)
    }
    
    //  MARK: Need to observe and post changes to database
    func observe(_ databaseReference: FIRDatabaseReference, completion: @escaping (DataSnapshot) -> Void) {
        reference(databaseReference).observe(.value) { (snapshot) in
            completion(snapshot)
        }
    }
    
    func post(parameters: [String: Any], to databaseReference: FIRDatabaseReference) {
        reference(databaseReference).childByAutoId().setValue(parameters)
    }
}

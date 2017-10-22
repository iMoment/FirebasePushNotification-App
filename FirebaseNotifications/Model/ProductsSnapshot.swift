//
//  ProductsSnapshot.swift
//  FirebaseNotifications
//
//  Created by Stanley Pan on 22/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import Foundation
import Firebase

struct ProductsSnapshot {
    let products: [Product]
    
    //  MARK: Making failable because we are not sure if the data coming back will be in the correct format
    init?(snapshot: DataSnapshot) {
        guard let snapDictionary = snapshot.value as? [String: [String: Any]] else { return nil }
        var products = [Product]()
        for snap in snapDictionary {
            guard let product = Product(valueDictionary: snap.value) else { continue }
            products.append(product)
        }
        self.products = products
    }
}

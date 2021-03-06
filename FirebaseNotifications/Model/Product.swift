//
//  Product.swift
//  FirebaseNotifications
//
//  Created by Stanley Pan on 21/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import Foundation

//  MARK: Probably should use structs when only working with pure data
struct Product {
    let title: String
    let cost: Double
    
    init(title: String, cost: Double) {
        self.title = title
        self.cost = cost
    }
    
    //  MARK: Failable with dictionary
    init?(valueDictionary: [String: Any]) {
        guard let title = valueDictionary["title"] as? String, let cost = valueDictionary["cost"] as? Double else { return nil }
        self.title = title
        self.cost = cost
    }
    
    func price() -> String {
        let costString = String(format: "%.2f", cost)
        return "$" + costString
    }
    
    func parameters() -> [String: Any] {
        let dictionary: [String: Any] = ["title": title,
                                         "cost": cost]
        return dictionary
    }
}

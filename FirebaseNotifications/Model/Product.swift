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
    
    func price() -> String {
        let costString = String(format: "%.2f", cost)
        return "$" + costString
    }
}

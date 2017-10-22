//
//  ProductsService.swift
//  FirebaseNotifications
//
//  Created by Stanley Pan on 22/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import Foundation

protocol ProductsServiceDelegate {
    func didChange(products: [Product])
}

class ProductsService {
    
    private init() {}
    static let sharedInstance = ProductsService()
    var delegate: ProductsServiceDelegate?
    
    func observeProducts() {
        FIRDatabaseService.sharedInstance.observe(.products) { (snapshot) in
            guard let productsSnapshot = ProductsSnapshot(snapshot: snapshot) else { return }
            self.delegate?.didChange(products: productsSnapshot.products)
        }
    }
    
    func post(product: Product) {
        FIRDatabaseService.sharedInstance.post(parameters: product.parameters(), to: .products)
    }
}

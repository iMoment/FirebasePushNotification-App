//
//  ViewController.swift
//  FirebaseNotifications
//
//  Created by Stanley Pan on 21/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //  MARK: Outlets
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    //  MARK: Variables
    var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.dataSource = self
        
        ProductsService.sharedInstance.delegate = self
        ProductsService.sharedInstance.observeProducts()
    }
    
    @IBAction func onAddTapped(sender: UIBarButtonItem) {
        AlertService.addProductAlert(in: self) { (product) in
            ProductsService.sharedInstance.post(product: product)
        }
    }
    
    @IBAction func onSubscribeTapped(sender: UIBarButtonItem) {
        AlertService.subscribeAlert(in: self)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else { return UICollectionViewCell() }
        
        let product = products[indexPath.item]
        cell.configure(with: product)
        
        return cell
    }
}

extension ViewController: ProductsServiceDelegate {
    func didChange(products: [Product]) {
        self.products = products
        self.mainCollectionView.reloadData()
    }
}


















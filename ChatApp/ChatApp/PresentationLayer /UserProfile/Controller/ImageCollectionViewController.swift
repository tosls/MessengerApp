//
//  ImageCollectionViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 19.11.2021.
//

import UIKit

class ImageCollectionViewController: UIViewController {
    
    var imageCollectionView = ImageCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let collectionSubview = imageCollectionView.setupCollectionView(view: view)
        
        view.addSubview(collectionSubview)
    }
}

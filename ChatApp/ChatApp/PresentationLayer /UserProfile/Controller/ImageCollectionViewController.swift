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
        
        collectionSubview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionSubview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionSubview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionSubview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            collectionSubview.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 30)
            ])
    }
}

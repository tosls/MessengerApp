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
        view.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        let collectionSubview = imageCollectionView.setupCollectionView(view: view)
        
        view.addSubview(collectionSubview)
        collectionSubview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionSubview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionSubview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionSubview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionSubview.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            ])
    }
}

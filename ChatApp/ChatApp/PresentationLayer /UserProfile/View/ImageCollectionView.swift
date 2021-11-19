//
//  ImageCollectionView.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 19.11.2021.
//

import UIKit

class ImageCollectionView: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {

    private var collectionView: UICollectionView?
    private var cellIdentifier = ProfileImageCollectionViewCell.CollectionViewCellIdentifier
    
    func setupCollectionView(view: UIView) -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100,
                                 height: 100)
        
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        guard let collectionView = collectionView else {fatalError()}
        collectionView.register(ProfileImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        
        return collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                            for: indexPath) as?
                ProfileImageCollectionViewCell else {
                    return UICollectionViewCell()
                }
        cell.configureCell(image: nil)
        return cell
    }
}

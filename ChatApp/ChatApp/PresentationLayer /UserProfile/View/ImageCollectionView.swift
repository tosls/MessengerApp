//
//  ImageCollectionView.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 19.11.2021.
//

import UIKit

class ImageCollectionView: NSObject, UICollectionViewDataSource {

    private var collectionView: UICollectionView?
    private var cellIdentifier = ProfileImageCollectionViewCell.CollectionViewCellIdentifier
    
    func setupCollectionView(view: UIView) -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        let margin: CGFloat = 20
        let cellsInRow: Int = 3
        collectionView = UICollectionView(frame: view.frame,
                                          collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        collectionView?.contentInsetAdjustmentBehavior = .always

        guard let collectionView = collectionView else {return UICollectionView()}
        let marginsAndInsets = layout.sectionInset.left + layout.sectionInset.right +
        collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right +
        layout.minimumInteritemSpacing * CGFloat(cellsInRow - 1)
        let itemSize = ((collectionView.bounds.size.width - marginsAndInsets) /
                        CGFloat(cellsInRow)).rounded(.down)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        collectionView.register(ProfileImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        
        return collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let imageCount = NetworkImageService.shared.imageURLs.count
        return imageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                            for: indexPath) as?
                ProfileImageCollectionViewCell else {
                    return UICollectionViewCell()
                }
        cell.configureCell(imageID: indexPath.row)
        return cell
    }
}

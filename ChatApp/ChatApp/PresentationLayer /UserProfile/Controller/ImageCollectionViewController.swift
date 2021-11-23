//
//  ImageCollectionViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 19.11.2021.
//

import UIKit

class ImageCollectionViewController: UIViewController {
    
    var imageCollectionView = ImageCollectionView()
    var updateProfileImage: ((Bool) -> Void)?
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = view.center
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
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
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        collectionSubview.delegate = self
    }
    
    func close() {
        dismiss(animated: true, completion: nil)
    }
}

extension ImageCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profileVC = ProfileViewController()
        close()
    }
}

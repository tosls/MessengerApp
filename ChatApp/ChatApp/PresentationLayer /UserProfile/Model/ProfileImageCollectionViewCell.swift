//
//  ProfileImageCollectionViewCell.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 19.11.2021.
//

import UIKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    
    static let CollectionViewCellIdentifier = "ProfileImageCollectionViewCell"
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "notImageAvailable.jpeg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 10
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage()
    }
    
    private func loadImage(imageNumber: Int, competion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            let urls = NetworkImageService.shared.imageURLs
            guard let url = URL(string: urls[imageNumber]) else {return}
            guard let data = try? Data(contentsOf: url) else {return}
            guard let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                competion(image)
            }
        }
    }
    
    func configureCell(image: Int) {
        loadImage(imageNumber: image) { image in
            self.imageView.image = image
        }
    }
}

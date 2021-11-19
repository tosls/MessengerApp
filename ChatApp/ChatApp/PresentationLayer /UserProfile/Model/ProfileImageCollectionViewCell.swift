//
//  ProfileImageCollectionViewCell.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 19.11.2021.
//

import UIKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    
    static let CollectionViewCellIdentifier = "ProfileImageCollectionViewCell"
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
        contentView.layer.cornerRadius = 10
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage()
    }
    
    func configureCell(image: UIImage?) {
        guard image != nil else {
            print("not image")
            imageView.image = UIImage(named: "cloud")
            return
        }
        imageView.image = image
    }
}

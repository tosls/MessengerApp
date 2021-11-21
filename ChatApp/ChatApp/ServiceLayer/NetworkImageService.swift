//
//  NetworkImageService.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 21.11.2021.
//

import UIKit

struct NetworkImageService {
    
    private func getImageData(completionHandler: @escaping (ImageResponseModel) -> Void) {
        let imageConfig = RequsetFactory.ImageRequest.randomImages()
        let sender = RequestSender()
        sender.send(config: imageConfig) { (result: Result<ImageResponseModel, Error>) in
            switch result {
            case .success(let imagesData):
                completionHandler(imagesData)
            case .failure(let error):
                print(error)
            }
        }
    }
//    
//    func fetchImages() -> [UIImage] {
//        let profileImages: [UIImage] = []
//        getImageData { imagesData in
//            for image in imagesData.hits {
//                guard let imageURL = URL(string: image.webformatURL) else {return}
//                if let data = try? Data(contentsOf: imageURL) {
//                    let newImage = UIImage(data: data)
//                    profileImages.app
//                } else {
//                    print("Not image url")
//                }
//            }
//        }
//        return profileImages
//    }
}

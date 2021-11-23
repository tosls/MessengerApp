//
//  NetworkImageService.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 21.11.2021.
//

import UIKit

class NetworkImageService {
    
    static let shared = NetworkImageService()
    
    private init() {}
    var imageURLs = [String]()
    
    func getImageData(completionHandler: @escaping (ImageResponseModel) -> Void) {
        let imageConfig = RequsetFactory.ImageRequest.randomImages()
        let sender = RequestSender()
        sender.send(config: imageConfig) { (result: Result<ImageResponseModel, Error>) in
            switch result {
            case .success(let imagesData):
                    print("get image data \(Thread.current)")
                    completionHandler(imagesData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getURL() {
        var url: [String] = []
        getImageData { model in
            for urls in model.hits {
                url.append(urls.webformatURL)
            }
        }
        DispatchQueue.main.async {
            self.imageURLs = url
        }
    }
}

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
                    completionHandler(imagesData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getImageURL() {
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
    
    func loadImage(imageID: Int, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            let urls = self.imageURLs
            guard let url = URL(string: urls[imageID]) else {return}
            guard let data = try? Data(contentsOf: url) else {return}
            guard let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}

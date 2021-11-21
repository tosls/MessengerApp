//
//  RequestFactory.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 21.11.2021.
//

import Foundation

struct RequsetFactory {

    struct ImageRequest {
        
        static func getRequest() -> RequestProtocol {
            let imagesURL = "https://pixabay.com/api/?key=\(pixabayAPI)&q=yellow+flowers&image_type=photo"
            guard let url = URL(string: imagesURL)  else {fatalError()}
            let imageUrlRequest = URLRequest(url: url)
            return ImageRequestClass(urlRequest: imageUrlRequest)
        }
        
        static func randomImages() -> RequestConfig<ImageParcer> {
            let randomImageRequest = getRequest()
            return RequestConfig<ImageParcer>(request: randomImageRequest, parser: ImageParcer())
        }
    }
}

struct ImageRequestClass: RequestProtocol {
    var urlRequest: URLRequest?
}

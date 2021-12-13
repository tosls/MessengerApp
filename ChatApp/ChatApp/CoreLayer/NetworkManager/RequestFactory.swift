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
            guard let imagesURL = Bundle.main.object(forInfoDictionaryKey: "PIXABAY_API_URL") as? String else {
                print(NetworkManagerError.invalidURL)
                fatalError()}
            guard let url = URL(string: imagesURL)  else {
                print(NetworkManagerError.invalidURL)
                fatalError()}
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

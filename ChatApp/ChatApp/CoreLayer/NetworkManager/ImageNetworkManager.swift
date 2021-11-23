//
//  ImageNetworkManager.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 20.11.2021.
//

import Foundation
import UIKit

class RequestSender: RequestSenderProtocol {
    let session = URLSession.shared
    
    func send<Parser>(config: RequestConfig<Parser>, completionHandler: @escaping (Result<Parser.Model, Error>) -> Void) {
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(.failure(NetworkManagerError.invalidURL))
            return
        }
        let task = session.dataTask(with: urlRequest) { (data: Data?, _ : URLResponse?, error: Error?) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard
                let data = data,
                let parsedModel: Parser.Model = config.parser.parse(data: data) else {
                    completionHandler(.failure(NetworkManagerError.decode))
                    return
                }
            completionHandler(.success(parsedModel))

        }
        task.resume()
    }
}

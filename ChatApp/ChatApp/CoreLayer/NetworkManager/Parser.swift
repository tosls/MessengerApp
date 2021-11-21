//
//  Parser.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 21.11.2021.
//

import Foundation

class ImageParcer: ParserProtocol {
    typealias Model = ImageResponseModel
    
    func parse(data: Data) -> ImageResponseModel? {
        var images: ImageResponseModel?
        do {
            let response = try JSONDecoder().decode(ImageResponseModel.self, from: data)
            images = response
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return images
    }
}

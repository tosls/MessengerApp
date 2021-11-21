//
//  RquestSenderProtocol.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 21.11.2021.
//

import Foundation

protocol RequestSenderProtocol {
    
    func send<Parser>(config: RequestConfig<Parser>,
                      completionHandler: @escaping (Result<Parser.Model, Error>) -> Void)
}

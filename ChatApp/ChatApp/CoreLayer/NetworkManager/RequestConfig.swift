//
//  RequestConfig.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 21.11.2021.
//

import Foundation

struct RequestConfig<Parser> where Parser: ParserProtocol {
    
    let request: RequestProtocol
    let parser: Parser
}

enum NetworkManagerError: Error {
    case invalidURL
    case decode
    case format
}

extension NetworkManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case.format:
            return "Received neither error nor data"
        case.decode:
            return "Got data in unexpected format, it might be error description"
        case.invalidURL:
            return "URL is incorrect"
        }
    }
}

//
//  ParserProtocol.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 21.11.2021.
//

import Foundation

protocol ParserProtocol {
    
    associatedtype Model
    func parse(data: Data) -> Model?
}

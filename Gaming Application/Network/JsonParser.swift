//
//  JsonParser.swift
//  Gaming Application
//
//  Created by Ali Murad on 10/02/2023.
//

import Foundation

// This protocol can refer to any parsing implementation. I have written JSON parser while any other implementation like XML etc can also be written.
internal protocol DataParsable {
    func parse<T>(type: T.Type, from data: Data) throws -> T where T: Decodable
}

// JSON parser implementation for DataParsable protocol.
internal struct JSONParser: DataParsable {
    func parse<T>(type: T.Type, from data: Data) throws -> T where T: Decodable {
        do {
            let response = try JSONDecoder().decode(type, from: data)
            return response
        } catch {
            throw error
        }
    }
}

//
//  Errors.swift
//  Gaming Application
//
//  Created by Ali Murad on 10/02/2023.
//

import Foundation
enum NetworkRequestError: Error {
    case unknown
    case parsingError
    case emptyData
    case notConnected
    case serverError(error: String)
}

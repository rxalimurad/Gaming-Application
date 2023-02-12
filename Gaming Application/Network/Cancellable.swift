//
//  Cancellable.swift
//  Gaming Application
//
//  Created by Ali Murad on 11/02/2023.
//

import Foundation

protocol Cancellable {
    // MARK: - Methods
    func cancel()
}

extension URLSessionTask: Cancellable {

}

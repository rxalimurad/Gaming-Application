//
//  URLs.swift
//  Gaming Application
//
//  Created by murad on 12/02/2023.
//

import Foundation

enum URLs {
    #if DEBUG
    static let serverURL = "api.rawg.io"
    #else // Release URL
    static let serverURL = "api.rawg.io"
    #endif
}

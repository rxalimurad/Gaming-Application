//
//  UserDefaults.swift
//  Gaming Application
//
//  Created by murad on 11/02/2023.
//

import Foundation
extension UserDefaults {
    var openedGames: [Int] {
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.openedGames)
        }
        get {
            UserDefaults.standard.object(forKey: Constants.UserDefaults.openedGames) as? [Int] ?? []
        }
    }
}

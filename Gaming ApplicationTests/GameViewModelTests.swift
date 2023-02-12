//
//  GameViewModelTests.swift
//  Gaming ApplicationTests
//
//  Created by murad on 12/02/2023.
//

import XCTest
@testable import Gaming_Application

class GameViewModelTests: XCTestCase {
    var sut = GameViewModelType?
    
    override func setUpWithError() throws {
        sut = GameViewModel(service: MockGameService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testExample() throws {
        sut?.getGamesList(search: "nrf")
    }


}

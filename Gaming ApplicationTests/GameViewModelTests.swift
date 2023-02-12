//
//  GameViewModelTests.swift
//  Gaming ApplicationTests
//
//  Created by murad on 12/02/2023.
//

import XCTest
@testable import Gaming_Application

class GameViewModelTests: XCTestCase {
    var sut: GameViewModelType?
    
    override func setUpWithError() throws {
        sut = GameViewModel(service: MockGameService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSuccessCase() throws {
        sut?.getGamesList(search: "GTA")
        XCTAssertNotNil(sut?.getGame(at: IndexPath(item: 0, section: 0)))
        XCTAssertEqual(sut?.getGame(at: IndexPath(item: 0, section: 0))?.name, "GTA V")
        XCTAssertEqual(sut?.getGame(at: IndexPath(item: 0, section: 0))?.metacritic, 98)
        XCTAssertEqual(sut?.getGame(at: IndexPath(item: 0, section: 0))?.genres?.count, 2)
        XCTAssertEqual(sut?.getGame(at: IndexPath(item: 0, section: 0))?.id, 0)
        XCTAssertEqual(sut?.getGamesListCount(), 2)
    }

    func testFailureCase() throws {
        sut?.getGamesList(search: "nrf")
        XCTAssertNil(sut?.getGame(at: IndexPath(item: 0, section: 0)))
        XCTAssertEqual(sut?.getGamesListCount(), 0)
    }

}

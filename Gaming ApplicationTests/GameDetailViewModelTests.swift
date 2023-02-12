//
//  GameDetailViewModelTests.swift
//  Gaming ApplicationTests
//
//  Created by murad on 13/02/2023.
//

import XCTest
@testable import Gaming_Application
class GameDetailViewModelTests: XCTestCase, GameDetailViewModelDelegate {
    var sut: GameDetailsViewModelType?
    var gameDetail: GameDetailModel?
    var nError: NetworkRequestError?
    var expectation: XCTestExpectation?
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
        gameDetail = nil
        nError = nil
    }
    
    func testSuccessCase() throws {
        let game = Game(id: 0, name: "GTA", backgroundImage: "url", metacritic: 45, genres: [Genre(name: "Action")])
        sut = GameDetailsViewModel(game: game, service: MockGameService(), localDBHandler: CoreDataHandler())
        sut?.delegate = self
        expectation = expectation(description: "Waiting for data")
        sut?.fetchGameDetails()
        waitForExpectations(timeout: 1)
        let result = try XCTUnwrap(gameDetail)
        XCTAssertEqual(result.name, "GTA V")
        XCTAssertNotNil(sut?.getRedditUrl())
        XCTAssertNotNil(sut?.getWebsiteUrl())
    }
    
    func testFailureCase() throws {
        let game = Game(id: nil, name: "GTA", backgroundImage: "url", metacritic: 45, genres: [Genre(name: "Action")])
        sut = GameDetailsViewModel(game: game, service: MockGameService(), localDBHandler: CoreDataHandler())
        sut?.delegate = self
        expectation = expectation(description: "Waiting for error")
        sut?.fetchGameDetails()
        waitForExpectations(timeout: 1)
        let result = try XCTUnwrap(nError)
        XCTAssertEqual(result, NetworkRequestError.emptyData)
        
    }
    
    func testFavourites() throws {
        let game = Game(id: 0, name: "GTA", backgroundImage: "url", metacritic: 45, genres: [Genre(name: "Action")])
        sut = GameDetailsViewModel(game: game, service: MockGameService(), localDBHandler: CoreDataHandler())
        sut?.addToFavourite()
        let sutUnWrap = try XCTUnwrap(sut)
        XCTAssertTrue(sutUnWrap.isFavourite())
        sut?.removeFromFavourite()
        XCTAssertFalse(sutUnWrap.isFavourite())
    }
    
    // MARK: - Delegates
    func updateUI(with gameDetail: GameDetailModel) {
        self.gameDetail = gameDetail
        expectation?.fulfill()
        expectation = nil
    }
    
    func showError(error: NetworkRequestError) {
        nError = error
        expectation?.fulfill()
        expectation = nil
    }
    
    
    
}

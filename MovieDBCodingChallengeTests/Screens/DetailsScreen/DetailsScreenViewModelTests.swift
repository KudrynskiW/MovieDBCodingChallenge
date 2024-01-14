//
//  DetailsScreenViewModelTests.swift
//  MovieDBCodingChallengeTests
//
//  Created by Wojciech Kudrynski on 14/01/2024.
//

import XCTest

@testable import MovieDBCodingChallenge

final class DetailsScreenViewModelTests: XCTestCase {
    var sut: DetailsScreenViewModel!
    var appCoordinatorMock: AppCoordinatorMock!
    var networkManagerMock: NetworkManagerMock!
    
    override func setUpWithError() throws {
        appCoordinatorMock = MockManager.getAppCoordinatorMock()
        networkManagerMock = MockManager.getNetworkManagerMock()
        
        sut = DetailsScreenViewModel(coordinator: appCoordinatorMock,
                                     networkManager: networkManagerMock,
                                     movie: MockManager.getMovieMock())
    }

    override func tearDownWithError() throws {
        appCoordinatorMock = nil
        networkManagerMock = nil
        sut = nil
    }

    func test_coordinateToMainScreen_called() throws {
        sut.closeDetails()
        
        XCTAssertTrue(appCoordinatorMock.coordinateToMainScreenCalled)
    }
}

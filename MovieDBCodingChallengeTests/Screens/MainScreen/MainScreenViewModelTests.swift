//
//  MainScreenViewModelTests.swift
//  MovieDBCodingChallengeTests
//
//  Created by Wojciech Kudrynski on 14/01/2024.
//

import XCTest
@testable import MovieDBCodingChallenge

final class MainScreenViewModelTests: XCTestCase {
    var sut: MainScreenViewModel!
    var appCoordinatorMock: AppCoordinatorMock!
    var networkManagerMock: NetworkManagerMock!
    
    override func setUpWithError() throws {
        appCoordinatorMock = MockManager.getAppCoordinatorMock()
        networkManagerMock = MockManager.getNetworkManagerMock()
        
        sut = MainScreenViewModel(coordinator: appCoordinatorMock,
                                  networkManager: networkManagerMock)
    }

    override func tearDownWithError() throws {
        appCoordinatorMock = nil
        networkManagerMock = nil
        sut = nil
    }

    func test_coordinateToDetailsScreen_called() throws {
        sut.coordinateToDetails(with: MockManager.getMovieMock())
        
        XCTAssertTrue(appCoordinatorMock.coordinateToDetilsCalled)
    }
    
    func test_fetchMovies_called() throws {
        sut.fetchMovies(page: 1, responseHandler: prepareResponseHandler())
        
        XCTAssertTrue(networkManagerMock.callWithRequestCalled)
    }
    
    func test_fetchSearchedMovies_called() throws {
        sut.fetchSearchedMovies(query: "", page: 1, responseHandler: prepareResponseHandler())
        
        XCTAssertTrue(networkManagerMock.callWithRequestCalled)
    }

    private func prepareResponseHandler() -> (Result<FetchMoviesResponse, NetworkManager.NetworkError>) -> Void {
        return { _ in }
    }
}

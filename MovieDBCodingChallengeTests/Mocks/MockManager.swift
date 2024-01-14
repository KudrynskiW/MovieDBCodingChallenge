//
//  MockManager.swift
//  MovieDBCodingChallengeTests
//
//  Created by Wojciech Kudrynski on 14/01/2024.
//

import Foundation
@testable import MovieDBCodingChallenge

class MockManager {
    static func getMovieMock() -> Movie {
        return Movie(id: 1, title: "test_title",
                     originalTitle: "originalTitle",
                     overview: "test_overview",
                     popularity: 1.0,
                     originalLanguage: "test_originalLanguage",
                     isAdult: false,
                     posterPath: "test_posterPath",
                     backdropPath: "test_backdropPath",
                     releaseDate: "test_releaseDate",
                     voteAvg: 1.0,
                     voteCount: 1)
    }
    
    static func getNetworkManagerMock() -> NetworkManagerMock {
        return NetworkManagerMock()
    }
    
    static func getAppCoordinatorMock() -> AppCoordinatorMock {
        return AppCoordinatorMock()
    }
}

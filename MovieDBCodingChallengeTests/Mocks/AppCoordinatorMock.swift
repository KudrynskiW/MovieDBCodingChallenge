//
//  AppCoordinatorMock.swift
//  MovieDBCodingChallengeTests
//
//  Created by Wojciech Kudrynski on 14/01/2024.
//

import Foundation
@testable import MovieDBCodingChallenge

class AppCoordinatorMock: AppCoordinator {
    var coordinateToMainScreenCalled = false
    var coordinateToDetilsCalled = false
    
    override func coordinate(to screen: AppCoordinator.ScreenType) {
        switch screen {
        case .mainScreen:
            coordinateToMainScreenCalled = true
        case .detailsScreen(_):
            coordinateToDetilsCalled = true
        }
    }
}

//
//  DetailsScreenViewModel.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 13/01/2024.
//

import Foundation

class DetailsScreenViewModel {
    let coordinator: AppCoordinator
    let networkManager: NetworkManager
    let movie: Movie
    
    init(coordinator: AppCoordinator,
         networkManager: NetworkManager,
         movie: Movie) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        self.movie = movie
    }
    
    func closeDetails() {
        coordinator.coordinate(to: .mainScreen)
    }
}

//
//  MainScreenViewModel.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 13/01/2024.
//

import Foundation

class MainScreenViewModel {
    let coordinator: AppCoordinator
    let networkManager: NetworkManager
    
    init(coordinator: AppCoordinator,
         networkManager: NetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
    
    func coordinateToDetails(with movie: Movie) {
        coordinator.coordinate(to: .detailsScreen(movie: movie))
    }
    
    func fetchMovies(page: Int, responseHandler: @escaping (Result<FetchMoviesResponse, NetworkManager.NetworkError>) -> Void) {
        networkManager.call(request: NowPlayingRequest(), type: FetchMoviesResponse.self, customParameters: "page=\(page)", completion: responseHandler)
    }
    
    func fetchSearchedMovies(query: String,
                             page: Int,
                             responseHandler: @escaping (Result<FetchMoviesResponse, NetworkManager.NetworkError>) -> Void) {
        networkManager.call(request: SearchRequest(), type: FetchMoviesResponse.self, customParameters: "query=\(query)&page=\(page)", completion: responseHandler)
    }
}

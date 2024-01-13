//
//  MainScreenViewController+TableView.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 13/01/2024.
//

import Foundation
import UIKit

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieCell, for: indexPath) as? MovieCell
        let movie = moviesList[indexPath.row]
        
        cell?.movie = movie
        cell?.setup()
        cell?.set(backgroundImage: movie.prepareImgUrl(imageType: .backdrop, imageSize: .small), with: viewModel?.networkManager)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.coordinateToDetails(with: moviesList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == moviesList.count - 1, currentPage < totalPages {
            currentPage += 1
            if actualMode == .nowPlaying {
                fetchMovies()
            } else {
                fetchSearchedMovies()
            }
        }
    }
}

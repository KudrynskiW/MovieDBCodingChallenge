//
//  MainScreenViewController.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 12/01/2024.
//

import UIKit

class MainScreenViewController: UIViewController {
    enum Constants {
        static let movieCell = "MovieCell"
    }
    
    enum Mode {
        case nowPlaying
        case search
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: MainScreenViewModel?
    var moviesList: [Movie] = []
    var currentPage = 1
    var totalPages = 1
    var actualMode: Mode = .nowPlaying
    var searchQuery = ""
    
    lazy var responseHandler: (Result<FetchMoviesResponse, NetworkManager.NetworkError>) -> Void = { [weak self] response in
        switch response {
        case .success(let data):
            if self?.currentPage == 1 {
                self?.moviesList = data.results
            } else {
                self?.moviesList.append(contentsOf: data.results)
            }
            
            self?.totalPages = data.totalPages
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                if self?.currentPage == 1 {
                    self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }
        case .failure(let err):
            print(err)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: Constants.movieCell, bundle: nil), forCellReuseIdentifier: Constants.movieCell)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func fetchMovies() {
        viewModel?.fetchMovies(page: currentPage, responseHandler: responseHandler)
    }
    
    func fetchSearchedMovies() {
        viewModel?.fetchSearchedMovies(query: searchQuery, page: currentPage, responseHandler: responseHandler)
    }
}

extension MainScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            actualMode = .nowPlaying
            currentPage = 1
            fetchMovies()
            return
        }
        
        if searchText.count == 1 {
            actualMode = .search
            currentPage = 1
        }
        searchQuery = searchText
        fetchSearchedMovies()
    }
}

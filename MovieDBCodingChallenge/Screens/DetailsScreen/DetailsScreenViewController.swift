//
//  DetailsScreenViewController.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 13/01/2024.
//

import UIKit

class DetailsScreenViewController: UIViewController {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel: DetailsScreenViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(close))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: viewModel?.movie.isFavourite ?? false ? "star.fill" : "star"),
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(addToFavourites))
        
        setup()
    }
    
    @objc
    private func close() {
        viewModel?.closeDetails()
    }
    
    @objc
    private func addToFavourites() {
        viewModel?.movie.toggleFavourite()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: viewModel?.movie.isFavourite ?? false ? "star.fill" : "star"),
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(addToFavourites))
    }
    
    private func setup() {
        guard let movie = viewModel?.movie,
              let networkManager = viewModel?.networkManager,
              let imagePath = movie.prepareImgUrl(imageType: .poster, imageSize: .small) else { return }
        
        networkManager.fetchImage(from: imagePath) { [weak self] result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self?.posterImage.image = UIImage(data: imageData)
                }
            case .failure(let err):
                print(err)
            }
        }
        
        titleLabel.text = movie.title + "\n(\(movie.originalTitle))"
        releaseDateLabel.text = movie.releaseDate
        scoreLabel.text = String(format: "Score\n %0.2f", movie.voteAvg)
        // Duplicated it just to show ScrollView:
        overviewLabel.text = movie.overview + movie.overview + movie.overview + movie.overview + movie.overview + movie.overview + movie.overview
    }
}

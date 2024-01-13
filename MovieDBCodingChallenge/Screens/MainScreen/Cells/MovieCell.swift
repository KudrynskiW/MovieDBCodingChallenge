//
//  MovieCell.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 12/01/2024.
//

import UIKit

class MovieCell: UITableViewCell {
    enum Constants {
        static let starEmpty = "star"
        static let starFilled = "star.fill"
        static let noBackdropPhoto = "xmark.rectangle"
    }
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieBackdrop: UIImageView!
    @IBOutlet weak var addToFavourites: UIButton!
    
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
        guard let movie else { return }
        addToFavourites.setImage(UIImage(systemName: movie.isFavourite ? Constants.starFilled : Constants.starEmpty), for: .normal)
        movieTitle.text = movie.title
        movieOverview.text = movie.overview
    }
    
    func set(backgroundImage: URL?, with networkManager: NetworkManager?) {
        guard let backgroundImage else { return }
        
        networkManager?.fetchImage(from: backgroundImage) { [weak self] result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        self?.movieBackdrop.image = image
                    } else {
                        self?.movieBackdrop.image = UIImage(systemName: Constants.noBackdropPhoto)
                    }
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    override func prepareForReuse() {
        movieTitle.text = ""
        movieOverview.text = ""
        movieBackdrop.image = nil
        movie = nil
    }
    
    @IBAction func toggleFavourite(_ sender: Any) {
        guard let movie else { return }
        
        movie.toggleFavourite()
        addToFavourites.setImage(UIImage(systemName: movie.isFavourite ? Constants.starFilled : Constants.starEmpty), for: .normal)
    }
}

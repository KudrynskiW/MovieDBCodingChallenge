//
//  Movie.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 12/01/2024.
//

import Foundation

struct Movie: Decodable {
    enum ImageProperties {
        enum Size {
            case small
            case regular
        }
        
        enum Image {
            case poster
            case backdrop
        }
    }
    
    
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let originalLanguage: String
    let isAdult: Bool
    let posterPath: String
    let backdropPath: String
    let releaseDate: String
    let voteAvg: Double
    let voteCount: Int
    var isFavourite: Bool {
        return UserDefaults.standard.value(forKey: String(id)) != nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id, overview, popularity, title
        case isAdult = "adult"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAvg = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(id: Int, 
         title: String,
         originalTitle: String,
         overview: String,
         popularity: Double,
         originalLanguage: String,
         isAdult: Bool,
         posterPath: String,
         backdropPath: String,
         releaseDate: String,
         voteAvg: Double,
         voteCount: Int) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.originalLanguage = originalLanguage
        self.isAdult = isAdult
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.voteAvg = voteAvg
        self.voteCount = voteCount
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
        overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? ""
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage) ?? ""
        isAdult = try values.decodeIfPresent(Bool.self, forKey: .isAdult) ?? false
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        voteAvg = try values.decodeIfPresent(Double.self, forKey: .voteAvg) ?? 0
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
    }
    
    func prepareImgUrl(imageType: ImageProperties.Image, imageSize: ImageProperties.Size) -> URL? {
        var baseUrl = "https://image.tmdb.org/t/p/"
        baseUrl.append(imageSize == .regular ? "original" : "w500")
        baseUrl.append(imageType == .poster ? posterPath : backdropPath)
        
        return URL(string: baseUrl)
    }
    
    func toggleFavourite() {
        let movieIdString = String(id)
        let isPresent = UserDefaults.standard.value(forKey: movieIdString) != nil
        if isPresent {
            UserDefaults.standard.removeObject(forKey: movieIdString)
        } else {
            UserDefaults.standard.setValue(true, forKey: movieIdString)
        }
    }
}

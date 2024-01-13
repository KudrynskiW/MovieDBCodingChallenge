//
//  FetchMoviesResponse.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 12/01/2024.
//

import Foundation

class FetchMoviesResponse: Decodable {
    let dates: DateRange
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        dates = try values.decodeIfPresent(DateRange.self, forKey: .dates) ?? DateRange(maximum: "", minimum: "")
        page = try values.decode(Int.self, forKey: .page)
        results = try values.decode([Movie].self, forKey: .results)
        totalPages = try values.decode(Int.self, forKey: .totalPages)
        totalResults = try values.decode(Int.self, forKey: .totalResults)
    }
}

//
//  SearchRequest.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 13/01/2024.
//

import Foundation

struct SearchRequest: RequestProtocol {
    var path: String = "/search/movie"
    var requestType: NetworkManager.httpMethod = .get
}

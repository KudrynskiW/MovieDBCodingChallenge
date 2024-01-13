//
//  NowPlayingRequest.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 12/01/2024.
//

import Foundation
 
struct NowPlayingRequest: RequestProtocol {
    var path: String = "/movie/now_playing"
    var requestType: NetworkManager.httpMethod = .get
}

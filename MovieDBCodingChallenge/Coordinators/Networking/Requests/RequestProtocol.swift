//
//  RequestProtocol.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 12/01/2024.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    var requestType: NetworkManager.httpMethod { get }
}

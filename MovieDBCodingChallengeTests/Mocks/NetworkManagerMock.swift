//
//  NetworkManagerMock.swift
//  MovieDBCodingChallengeTests
//
//  Created by Wojciech Kudrynski on 14/01/2024.
//

import Foundation
@testable import MovieDBCodingChallenge

class NetworkManagerMock: NetworkManager {
    var callWithRequestCalled = false
    
    override func call<T>(request: RequestProtocol, type: T.Type, customParameters: String = "", completion: @escaping (Result<T, NetworkManager.NetworkError>) -> Void) where T : Decodable {
        callWithRequestCalled = true
    }
}

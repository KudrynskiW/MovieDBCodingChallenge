//
//  NetworkManager.swift
//  MovieDBCodingChallenge
//
//  Created by Wojciech Kudrynski on 12/01/2024.
//

import Foundation

class NetworkManager {
    enum Constants {
        static let basePathURLString = "https://api.themoviedb.org/3"
        static let tokenHeaderField = "Authorization"
    }
    
    enum NetworkError: Error {
        case genericError
        case invalidURL
        case responseError
        case dataDecodingError
    }
    
    enum httpMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func call<T: Decodable>(request: RequestProtocol, type: T.Type, customParameters: String = "", completion: @escaping (Result<T, NetworkError>) -> Void) {
        let basePath = Constants.basePathURLString
        
        guard let url = URL(string: basePath + request.path + "?\(customParameters)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        
        Task { [weak self] in
            guard let self else {
                completion(.failure(.genericError))
                return
            }
            do {
                let (data, _) = try await self.session.data(for: self.prepareURLRequest(with: url, requestType: request.requestType))
                
                if let response = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.dataDecodingError))
                }
            } catch {
                completion(.failure(.responseError))
            }
        }
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        Task { [weak self] in
            guard let self else {
                completion(.failure(.genericError))
                return
            }
            do {
                let (data, _) = try await self.session.data(for: URLRequest(url: url))
                
                completion(.success(data))
            } catch {
                completion(.failure(.responseError))
            }
        }
    }
    
    private func prepareURLRequest(with url: URL, requestType: httpMethod) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        let token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MGMxMWE5YTE4NDRiOGQ4ZDI1Y2ZmNzc0MzdhZDQ3NyIsInN1YiI6IjY1YTE4Y2FjNmQ2NzVhMDEyZWIyNzZlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.m8jpbqqhTHuwjbdn_zMpoHYv-bXAw0CR2uw-ZEsRDQA"
        urlRequest.setValue(token, forHTTPHeaderField: Constants.tokenHeaderField)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.cachePolicy = .useProtocolCachePolicy
        urlRequest.timeoutInterval = 10.0
        
        return urlRequest
    }
}

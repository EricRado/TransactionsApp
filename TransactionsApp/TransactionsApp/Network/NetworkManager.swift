//
//  NetworkManager.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/7/21.
//

import Foundation

enum NetworkError: String, Error {
    case missingURL = "URL is nil."
    case unknown
}

final class NetworkManager {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: EndpointConstructable, completion: @escaping (Result<T, Error>) -> ()) {
        guard let request =  buildRequest(from: endpoint) else {
            completion(.failure(NetworkError.missingURL))
            return
        }
        
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let dtos = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(dtos))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NetworkError.unknown))
            }
        }.resume()
    }
    
    private func buildRequest(from endpoint: EndpointConstructable) -> URLRequest? {
        guard let url = URL(string: endpoint.baseURL)?.appendingPathComponent(endpoint.path) else {
            return nil
        }
        
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        switch endpoint.httpTask {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}

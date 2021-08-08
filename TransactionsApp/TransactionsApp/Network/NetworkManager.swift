//
//  NetworkManager.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/7/21.
//

import Foundation

enum NetworkError: String, Error {
    case missingUrl = "URL is nil."
    case unknown
}

final class NetworkManager {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: EndpointConstructable, completion: @escaping (Result<T, Error>) -> ()) {
        guard let request =  buildRequest(from: endpoint) else {
            completion(.failure(NetworkError.missingUrl))
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
    
    func requestImage(_ urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.missingUrl))
            return
        }

        let cache = URLCache.shared
        let request = URLRequest(url: url)

        if let cachedImageData = cache.cachedResponse(for: request)?.data {
            completion(.success(cachedImageData))
        } else {
            session.downloadTask(with: url) { url, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let validURL = url,
                    let response = response,
                    let data = try? Data(contentsOf: validURL) {

                    let cachedImageData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedImageData, for: request)
                    completion(.success(data))
                } else {
                    completion(.failure(NetworkError.unknown))
                }
            }.resume()
        }
    }
    
    private func buildRequest(from endpoint: EndpointConstructable) -> URLRequest? {
        guard let url = URL(string: endpoint.baseUrl)?.appendingPathComponent(endpoint.path) else {
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

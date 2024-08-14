//
//  WebService.swift
//  Newbie
//
//  Created by Raj.P, Varun (Cognizant) on 12/08/24.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case invalidReponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
}

final class WebService {
    
    func load<T: Codable>(url: URL, urlSession: URLSession = .shared, completion: @escaping(Result<T, NetworkError>) -> ()) {
        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request) { data, response, err in
            if let err = err {
                completion(.failure(NetworkError.failedRequest(description: err.localizedDescription)))
            } else if let data = data {
                if let json = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(json))
                } else {
                    completion(.failure(NetworkError.invalidReponseModel))
                }
            }
        }
        task.resume()
    }
    
}

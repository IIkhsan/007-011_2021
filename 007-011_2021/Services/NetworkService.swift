//
//  RemoteDataManager.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 08.12.2021.
//

import Foundation

//MARK: - Network errors enum
enum NetworkErrors: Error {
    case badURL
}

class NetworkService {
    //MARK: - Singleton
    static let shared = NetworkService()
    
    //MARK: - NetworkManager properties
    private let operationQueue = OperationQueue()
    
    //MARK: - Get methods
    /// Get word from API
    /// - Parameters:
    ///   - word: searching word
    ///   - completion: response
    func getWord(word: String, completion: @escaping ((Result<[WordResponseModel], Error>) -> Void)) {
        
        operationQueue.addOperation {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)")
            else {
                completion(.failure(NetworkErrors.badURL))
                return
            }
            var request = URLRequest(url: url)
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.httpMethod = "GET"
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let words = try JSONDecoder().decode([WordResponseModel].self, from: data)
                        completion(.success(words))
                    } catch {
                        print("Error is here! \(error)")
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }
            dataTask.resume()
        }
    }
}

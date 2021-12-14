//
//  NetworkService.swift
//  007-011_2021
//
//  Created by Evans Owamoyo on 12.12.2021.
//

import Foundation

struct NetworkService {
    // MARK: private properties
    private let urlString = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    private var session: URLSession = {
        let config: URLSessionConfiguration = .default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return URLSession(configuration: config)
    }()
    
    // MARK: public functions
    func fetchWord(with word: String, completion: @escaping (Result<[Word], DictionaryError>) -> Void) {
        guard let url = URL(string: "\(urlString)\(word)") else {
            completion(.failure(DictionaryError(message: "Invalid URL")))
            return
        }

        let queue = OperationQueue()
        queue.qualityOfService = .utility
        queue.maxConcurrentOperationCount = 3
        queue.addOperation {
            let task = session.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    completion(.failure(DictionaryError(message: "Error while fetching data with stacktrace \(error)")))
                } else if let data = data {
                    // check for 404 response code
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode == 404 {
                            completion(.failure(DictionaryError(message: "Not Found")))
                            return
                        }
                    }
                    
                    // parse data
                    let decoder = JSONDecoder()
                    do {
                        let words = try decoder.decode([Word].self, from: data)
                        completion(.success(words))
                    } catch {
                        completion(.failure(DictionaryError(message: "Failed to parse JSON from server \(String(data: data, encoding: .utf8) ?? "")")))
                    }
                } else {
                    completion(.failure(DictionaryError(message: "No response from server")))
                }
            }
            task.resume()
        }
        
    }
}

//
//  NetworkService.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 21.11.2021.
//

import Foundation

final class NetworkService {
    // private properties
    private let configuration = URLSessionConfiguration.default
    private let decoder = JSONDecoder()
    
    // MARK: - Public functions
    func getWord(word: String, completion: @escaping ((Result<[Word], Error>) -> Void)) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            let session = URLSession(configuration: self.configuration)
            guard let wordURL = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else {
                completion(.failure(NSLocalizedString("Invalid url!", comment: "Invalid url") as! Error))
                return
            }
            var request = URLRequest(url: wordURL)
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.httpMethod = "GET"
            
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                var result: Result<[Word], Error> = .success([])
                
                if let error = error {
                    result = .failure(error)
                } else if let data = data {
                    do {
                        let words = try self.decoder.decode([Word].self, from: data)
                        result = .success(words)
                    } catch {
                        result = .failure(error)
                    }
                }
                
                completion(result)
            }
            
            dataTask.resume()
        }
    }
}

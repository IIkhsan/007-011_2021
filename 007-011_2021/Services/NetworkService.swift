//
//  NetworkService.swift
//  007-011_2021
//
//  Created by Семен Соколов on 24.11.2021.

import Foundation

final class NetworkService {
    
    //MARK: - Properties
    let configuration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    let operationQueue = OperationQueue()
    
    //MARK: - Get word func
    func getWord(word: String, completion: @escaping ((Result<[Word], Error>) -> Void)) {
        operationQueue.addOperation {
            let session = URLSession(configuration: self.configuration)
            if let wordURL = URL(string:"https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") {
                var request = URLRequest(url: wordURL)
                request.cachePolicy = .reloadIgnoringCacheData
                request.httpMethod = "GET"
                let dataTask = session.dataTask(with: request) { data, response, error in
                    var result: Result<[Word], Error> = .success([])
                    if let error = error {
                        result = .failure(error)
                    } else if let data = data {
                        do {
                            let word = try self.decoder.decode([Word].self, from: data)
                            result = .success(word)
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
}

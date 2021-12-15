//
//  NetworkService.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 24.11.2021.
//

import UIKit
import Foundation

final class NetworkService {
    
    //MARK: - Properties
    let configuration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    static let shared = NetworkService()
    
    //MARK: - Functions
    func getWord(request: String, completion: @escaping((Result<[Word], Error>) -> Void)) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            let session = URLSession(configuration: self.configuration)
            let wordsURL = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(request)")!
            
            var request = URLRequest(url: wordsURL)
            request.cachePolicy = .reloadIgnoringCacheData
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

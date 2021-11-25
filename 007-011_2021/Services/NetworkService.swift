//
//  NetworkService.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 24.11.2021.
//

import UIKit
import Foundation

final class NetworkService {
    
    let configuration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    
    
    func getWord(completion: @escaping((Result<[Word], Error>) -> Void)) {
        
        let session = URLSession(configuration: configuration)
        let wordsURL = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/hello")!
    
        var request = URLRequest(url: wordsURL)
        request.cachePolicy = .reloadIgnoringCacheData
        request.httpMethod = "GET"
    
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            var result: Result<[Word], Error> = .success([])
            if let error = error {
                result = .failure(error)
            } else if let data = data {
                do{
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

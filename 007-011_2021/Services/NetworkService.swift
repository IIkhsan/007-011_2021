//
//  NetworkService.swift
//  007-011_2021
//
//  Created by Evans Owamoyo on 12.12.2021.
//

import Foundation

struct NetworkService {
    private let urlString = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    func fetchWord(with word: String, completion: @escaping (Result<[Word], DictionaryError>) -> Void) {
        guard let url = URL(string: "\(urlString)\(word)") else {
            completion(.failure(DictionaryError(message: "Invalid URL")))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(DictionaryError(message: "Error while fetching data with stacktrace \(error)")))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let words = try decoder.decode([Word].self, from: data)
                    completion(.success(words))
                } catch {
                    completion(.failure(DictionaryError(message: "Failed to parse JSON from server")))
                }
            } else {
                completion(.failure(DictionaryError(message: "No response from server")))
            }
        }
        task.resume()
    }
}

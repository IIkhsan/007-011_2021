//
//  NetworkService.swift
//  007-011_2021
//
//  Created by Рустем on 14.12.2021.
//

import Foundation

final class NetworkService {
    
    // MARK: - Enum
    
    enum NetworkError: Error {
        case inputError
        case noDataAvailable
        case processingError
        case serverUnavailable
    }
    
    // MARK: - Properties
    
    static let shared = NetworkService()
    let apiURL: String = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    // MARK: - Lifecycle
    
    private init(){}
    
    // MARK: - Functions
    
    func getData(word: String, completion: @escaping(Result<Word, NetworkError>) -> Void) {
        guard let url = URL(string: apiURL + word) else {
            completion(.failure(.inputError))
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.processingError))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let wordInfo = try jsonDecoder.decode([Word].self, from: jsonData)
                
                completion(.success(wordInfo.first!))
            } catch {
                completion(.failure(.noDataAvailable))
            }
        }
        dataTask.resume()
    }
    
}

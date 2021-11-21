//
//  NetworkService.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 21.11.2021.
//

import Foundation

class NetworkService {
    
    //MARK: - Properties
    static let shared = NetworkService()
    private var resourceURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    private var configuration: URLSessionConfiguration  {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return configuration
    }
    
    private init() {
        
    }
    
    public func getWord(word: String) -> Result<Word, Error>  {
        let wordURL = URL(string: resourceURL + word)
        let session = URLSession(configuration: configuration)
        guard let wordURL = wordURL else {
            return Result.failure(NetworkErrors.invalidURL)
        }
        var result: Result<Word, Error> = Result.failure(NetworkErrors.unknownError)
        session.dataTask(with: wordURL) { data, response, err in
            if err != nil {
                result = Result.failure(err!)
                return
            }
            guard let data = data else {
                result = Result.failure(NetworkErrors.unknownError)
                return
            }
            do {
                let word = try JSONDecoder().decode(Word.self, from: data)
                result = Result.success(word)
            } catch {
                result = Result.failure(error)
                print("cant decode")
            }
        }.resume()
        return result
    }
}


enum NetworkErrors: Error {
    case invalidURL
    case unknownError
}

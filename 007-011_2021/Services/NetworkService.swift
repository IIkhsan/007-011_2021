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
    
    public func fetchWord(word: String, completion: @escaping(Result<Word, Error>) -> Void)  {
        let queue = OperationQueue()
        queue.qualityOfService = .utility
        queue.addOperation { [weak self] in
            guard let strongSelf = self else { return }
            let wordURL = URL(string: strongSelf.resourceURL + word)
            let session = URLSession(configuration: strongSelf.configuration)
            guard let wordURL = wordURL else {
                completion(Result.failure(NetworkErrors.invalidURL))
                return
                }
            session.dataTask(with: wordURL) { data, response, err in
                if err != nil {
                    completion(Result.failure(err!))
                    return
                }
                guard let data = data else {
                    completion(Result.failure(NetworkErrors.unknownError))
                    return
                }
                do {
                    let word = try JSONDecoder().decode([Word].self, from: data)
                    guard word.first != nil else {
                        completion(Result.failure(NetworkErrors.unknownError))
                        return
                    }
                    DispatchQueue.main.async {
                    completion(Result.success(word.first!))
                    }
                } catch {
                    completion(Result.failure((error)))
                }
            }.resume()
        }
    }
}


enum NetworkErrors: Error {
    case invalidURL
    case unknownError
}

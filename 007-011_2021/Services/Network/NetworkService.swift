//
//  NetworkRouter.swift
//  007-011_2021
//
//  Created by Alexandr Onischenko on 29.11.2021.
//


import Foundation

class NetworkService{
    
    //MARK: - Properties
    
    static let shared = NetworkService()
    let decoder = JSONDecoder()
    let session = URLSession.shared
    
    // MARK: - Private Properties
    
    private var configuration: URLSessionConfiguration  {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return configuration
    }
    
    // MARK: - Private Initializer
    
    private init() {}
    
    //MARK: - Public functions
    
    public func getWord(_ word: String, completion: @escaping(ObtainWordsResult) -> Void) {
        
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/" + word) else { return print("Error: URL is not correct)")}
        
        session.dataTask(with: url){ [weak self] (data, response, error) in
            var result: ObtainWordsResult
            guard let strongSelf = self else { return result = .success(words: []) }
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if error == nil, let parsData = data {
                
                guard let words = try? strongSelf.decoder.decode([Word].self, from: parsData) else { return result = .success(words: []) }
                result = .success(words: words)
            }
            else {
                result = .failure(error: error!)
            }
            
            completion(result)
        }.resume()
    }
}

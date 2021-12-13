//
//  NetworkManager.swift
//  007-011_2021
//
//  Created by Тимур Миргалиев on 20.11.2021.
//

import Foundation

class NetworkManager {
    
    //MARK: - Private properties
    private let sessionConfiguration = URLSessionConfiguration.default
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    private let musicDecoder = PropertyListDecoder()
    
    func obtainWords(comletion: @escaping ((Result<[Word], Error>) -> Void), generalUrl: URL) {
        let request = URLRequest(url: generalUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            self.session.dataTask(with: request) { [weak self] (data, response, error) in
                
                var result: Result<[Word], Error> = .success([])
                
                defer {
                    DispatchQueue.global().async {
                        comletion(result)
                    }
                }
                guard let strongSelf = self else {
                    result = .failure(error!)
                    return
                }
                if error == nil, let parsData = data {
                    guard let words = try? strongSelf.decoder.decode([Word].self, from: parsData) else {
                        result = .success([])
                        return
                    }
                    result = .success(words)
                    
                } else {
                    result = .failure(error!)
                }
                comletion(result)
            }.resume()
        }
    }
}

//
//  NetworkManager.swift
//  007-011_2021
//
//  Created by Тимур Миргалиев on 20.11.2021.
//

import Foundation

enum ObtainWordResalt {
    case success(words: [Word])
    case failure(error: Error)
}

class NetworkManager {

    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    let musicDecoder = PropertyListDecoder()
    
    func obtainWords(comletion: @escaping (ObtainWordResalt) -> Void, generalUrl: URL) {
        
        let request = URLRequest(url: generalUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        
        session.dataTask(with: request) { [weak self] (data, response, error) in
            
            var result: ObtainWordResalt
            
            defer {
                DispatchQueue.global().async {
                    comletion(result)
                }
            }
            
            guard let strongSelf = self else {
                result = .failure(error: error!)
                return
            }
            
            if error == nil, let parsData = data {
                guard let words = try? strongSelf.decoder.decode([Word].self, from: parsData) else {
                    result = .success(words: [])
                    return
                }
                result = .success(words: words)
                
            } else {
                result = .failure(error: error!)
            }
            comletion(result)
        }.resume()
    }
}

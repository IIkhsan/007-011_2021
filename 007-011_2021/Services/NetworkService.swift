//
//  NetworkService.swift
//  007-011_2021
//
//  Created by Marat Giniyatov on 13.12.2021.
//

import Foundation

class NetworkService {

       func getWord(word: String, completion: @escaping ((Result<[Word], Error>) -> Void)) {
           let operationQueue = OperationQueue()
           operationQueue.addOperation {
               let session = URLSession(configuration: URLSessionConfiguration.default)
               guard let wordURL =
                    URL(string:"https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else {
                   completion(.failure(NSLocalizedString("Неправильный URL", comment: "Неправильный URL") as! Error))

                   return
               }
               var request = URLRequest(url: wordURL)
               request.cachePolicy = .reloadIgnoringLocalCacheData
               request.httpMethod = "GET"
               let dataTask = session.dataTask(with: request) {
                   data, response, error in
                   var result: Result<[Word], Error> = .success([])
                   if let error = error {
                       result = .failure(error)
                   } else if let data = data {
                       do {
                           let word = try JSONDecoder().decode([Word].self, from: data)
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

//
//  NetworkService.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 22.11.2021.
//

import Foundation
import SystemConfiguration

protocol NetworkService {
  func getWords(_ word: String, completion: @escaping ((Result<[Word], Error>) -> Void))
}

final class NetworkServiceImpl: NetworkService {
  // MARK: - Properties
  private let configuration = URLSessionConfiguration.default
  private let decoder = JSONDecoder()
  private let apiUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/"
  private let operationQueue = OperationQueue()
  
  // Shared
  static let shared: NetworkService = NetworkServiceImpl()
  
  // MARK: - Init
  init() {
    operationQueue.qualityOfService = .userInteractive
    operationQueue.maxConcurrentOperationCount = 1
  }
  
  // MARK: - NetworkService
  func getWords(_ word: String, completion: @escaping ((Result<[Word], Error>) -> Void)) {
    operationQueue.addOperation {
      let session = URLSession(configuration: self.configuration)
      guard let url = URL(string: self.apiUrl + word) else {
        completion(.failure(Errors.invaildUrlError))
        return
      }
      var request = URLRequest(url: url)
      request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
      request.httpMethod = "GET"
      
      let dataTask = session.dataTask(with: request) { data, response, error in
        var result: Result<[Word], Error> = .success([])
        if let error = error {
          result = .failure(error)
        } else if let data = data {
          do {
            let words = try self.decoder.decode([Word].self, from: data)
            result = .success(words)
          } catch let error {
            result = .failure(error)
          }
        }
        completion(result)
      }
      dataTask.resume()
    }
  }
}

//
//  NetworkServiceInteractor.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 08.12.2021.
//

import Foundation

class NetworkServiceInteractor {
    //MARK: - Singleton
    static let shared = NetworkServiceInteractor()
    
    //MARK: - Interactor's properties
    private let networkService = NetworkService.shared
    private let operationQueue = OperationQueue()
    
    //MARK: - Interactor's methods
    func getWords(word: String, completion: @escaping (Result<[WordResponseModel], Error>) -> Void) {
        networkService.getWord(word: word, completion: completion)
    }
}

import Foundation

// MARK: - Private enums

private enum MessagesForErrors: String {
    case invalidLinkMessage = "Invalid URL link!"
    case convertErrorMessage = "Cannot convert self to strongSelf!"
    case decodeErrorMessage = "Decode error!"
}

class NetworkService {
    
    // Public properties
    
    static let shared = NetworkService()
    
    // Private properties
    
    private let sessionConfiguration = URLSessionConfiguration.default
    private let decoder = JSONDecoder()
    private let link = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    // MARK: - Init properties
    
    private init() {
    }
    
    // MARK: - Network funcs
    
    public func getItems(word: String, completion: @escaping(Result<[Word], Error>) -> Void) {
        guard let link = URL(string: self.link + word) else {
            completion(.failure(Errors.invalidLink(MessagesForErrors.invalidLinkMessage.rawValue)))
            return
        }
        var request = URLRequest(url: link)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.httpMethod = "GET"
        let session = URLSession(configuration: self.sessionConfiguration)
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            session.dataTask(with: request) { [weak self] data, response, error in
                var result: Result<[Word], Error> = .success([])
                defer {
                    DispatchQueue.global().async {
                        completion(result)
                    }
                }
                guard let strongSelf = self else {
                    completion(.failure(Errors.convertError(MessagesForErrors.convertErrorMessage.rawValue)))
                    return
                }
                if error == nil, let data = data {
                    guard let words = try? strongSelf.decoder.decode([Word].self, from: data) else {
                        result = .failure(Errors.decodeError(MessagesForErrors.decodeErrorMessage.rawValue))
                        return
                    }
                    result = .success(words)
                }
                else {
                    result = .failure(error!)
                }
                completion(result)
            }.resume()
        }
    }
}

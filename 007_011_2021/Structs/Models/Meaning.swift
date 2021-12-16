import Foundation

struct Meaning: Codable {
    let partOfSpeech: String?
    let definitions: [Definition]?
    
    enum CodingKeys: String, CodingKey {
        case partOfSpeech = "partOfSpeech"
        case definitions = "definitions"
    }
}

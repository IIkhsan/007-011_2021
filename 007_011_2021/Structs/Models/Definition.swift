import Foundation

struct Definition: Codable {
    let definition: String?
    let example: String?
    let synonyms: [String]?
    
    enum CodingKeys: String, CodingKey {
        case definition = "definition"
        case example = "example"
        case synonyms = "synonyms"
    }
}

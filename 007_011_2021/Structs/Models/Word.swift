import Foundation

struct Word: Codable {
    let title: String
    let phonetics: [Phonetics]?
    let meanings: [Meaning]?
    
    enum CodingKeys: String, CodingKey {
        case title = "word"
        case phonetics = "phonetics"
        case meanings = "meanings"
    }
}
    

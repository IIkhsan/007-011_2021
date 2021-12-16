import Foundation

struct Phonetics: Codable {
    let audio: String?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case audio = "audio"
        case text = "text"
    }
}

import Foundation

enum Errors: Error {
    case invalidLink(String)
    case convertError(String)
    case decodeError(String)
}

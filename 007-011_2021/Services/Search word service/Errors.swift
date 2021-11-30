//
//  Errors.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 23.11.2021.
//

import Foundation

enum Errors: Error {
  case invaildUrlError
  case parsingError
}

extension Errors: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .invaildUrlError:
      return NSLocalizedString("Found invalid url", comment: "Invalid url")
    case .parsingError:
      return NSLocalizedString("Failure to parse", comment: "Can't parse")
    }
  }
}

//
//  DogError.swift
//  CleverDog
//
//

import Foundation

public enum DogError: Error {
    case databaseError
    case networkError
    case mappingError
    case previousImageNilError

    public var message: String {
        switch self {
        case .databaseError:
            return "Database Error"
        case .networkError:
            return "Database Error"
        case .mappingError:
            return "Mapping Error"
        case .previousImageNilError:
            return "Previous Image nil Error"
        }
    }
}

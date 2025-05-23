//
//  ImmigrantError.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 07/05/25.
//

import Foundation

public enum ImmigrantError: ErrorMappable {
    case couldntFindImmigrants
    case couldntFindImmigrant
    case couldntSaveImmigrant
    case couldntSaveImmigrants
}

extension ImmigrantError {
    public var debugDescription: String {
        switch self {
        case .couldntFindImmigrants:
            return """
            ❌  Couldn't find immigrants  ❌
            """
        case .couldntFindImmigrant:
            return """
            ❌ Couldn't find immigrants information  ❌
            """
        case .couldntSaveImmigrant:
            return """
            ❌ Couldn't save immigrant's information  ❌
            """
        case .couldntSaveImmigrants:
            return """
            ❌ Couldn't save immigrants' information  ❌
            """
        }
    }
    
    public var description: String {
        switch self {
        case .couldntFindImmigrants,
             .couldntFindImmigrant,
             .couldntSaveImmigrant,
             .couldntSaveImmigrants:
            return "Something went wrong. Please check your internet connection and try again"
        }
    }
}


//
//  ImmigrantProvider.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 06/05/25.
//

import Foundation

enum ImmigrantProvider {
    case getImmigrants(_ parameters: ImmigrantSearchDTO)
}

extension ImmigrantProvider: TargetProvider {
    var path: String? {
        "/rest/v1/"
    }
    
    var endpoint: String? {
        switch self {
        case .getImmigrants:
            return "immigration_immigrants"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getImmigrants:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getImmigrants(let searchDTO):
            return .requestURLEncodable(parameters: searchDTO.asQueryParameters)
        }
    }
}

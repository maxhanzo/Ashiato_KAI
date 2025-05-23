//
//  ImmigrantLocalRepository.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 07/05/25.
//


import Combine
import Foundation

public struct ImmigrantLocalRepository {
    let dataBase: SwiftDataStoring
    
    public init(mocked: Bool = false) {
        dataBase = mocked ? Database.mocked : Database.main
    }
    
    // For Unit Test purposes
    public init(_ dataBase: SwiftDataStoring) {
        self.dataBase = dataBase
    }
}

extension ImmigrantLocalRepository: ImmigrantRepository {
    public func save(_ immigrant: ImmigrantOM) -> AnyPublisher<ImmigrantOM, any Error> {
        dataBase
            .insert(immigrant, autoSave: true)
            .map { immigrant }
            .mapError { _ -> Error in
                ImmigrantError.couldntFindImmigrant
            }
            .eraseToAnyPublisher()
    }
    public func save(_ immigrants: [ImmigrantOM]) -> AnyPublisher<[ImmigrantOM], any Error> {
        dataBase
            .insert(immigrants, autoSave: true)
            .map { immigrants }
            .mapError { _ -> Error in
                ImmigrantError.couldntFindImmigrant
            }
            .eraseToAnyPublisher()
    }
    
    public func getImmigrant(_ byID: Int) -> AnyPublisher<ImmigrantOM?, any Error> {
        let settings: FetchSettings<ImmigrantOM> = .init(
            predicate: #Predicate { $0.immigrantID == byID },
            limit: 1
        )
        
        return dataBase.fetch(settings)
            .map(\.first)
            .mapError { _ -> Error in
                ImmigrantError.couldntFindImmigrant
            }
            .eraseToAnyPublisher()
    }
    
    public func getImmigrants(_ byGroupID: Int) -> AnyPublisher<[ImmigrantOM], any Error> {
        let settings: FetchSettings<ImmigrantOM> = .init(
            predicate: #Predicate { $0.groupID == byGroupID }
        )
        
        return dataBase.fetch(settings)
            .mapError { _ -> Error in
                ImmigrantError.couldntFindImmigrants
            }
            .eraseToAnyPublisher()
    }
}

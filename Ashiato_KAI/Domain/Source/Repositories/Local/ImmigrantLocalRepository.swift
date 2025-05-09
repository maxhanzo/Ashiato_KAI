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
    
    public func fetchImmigrant(_ byId: Int) -> AnyPublisher<ImmigrantOM?, any Error> {
        let settings: FetchSettings<ImmigrantOM> = .init(
            predicate: #Predicate { $0.immigrantId == byId },
            limit: 1
        )
        
        return dataBase.fetch(settings)
            .map(\.first)
            .mapError { _ -> Error in
                ImmigrantError.couldntFindImmigrant
            }
            .eraseToAnyPublisher()
    }
    
    public func fetchImmigrants(_ parameters: ImmigrantSearchDTO) -> AnyPublisher<[ImmigrantOM], any Error> {
        let settings: FetchSettings<ImmigrantOM> = .init(
            predicate: #Predicate { immigrant in
                var matches = true
                
                if let immigrantId = parameters.immigrantId {
                    matches = matches && immigrant.immigrantId == immigrantId
                }
                if let nameRomaji = parameters.nameRomaji {
                    matches = matches && immigrant.nameRomaji.localizedStandardContains(nameRomaji)
                }
                if let surnameRomaji = parameters.surnameRomaji {
                    matches = matches && immigrant.surnameRomaji.localizedStandardContains(surnameRomaji)
                }
                if let groupId = parameters.groupId {
                    matches = matches && immigrant.groupId == groupId
                }
                if let year = parameters.year {
                    matches = matches && immigrant.year == year
                }
                if let arrivalDate = parameters.arrivalDate?.toDate() {
                    matches = matches && immigrant.arrivalDate == arrivalDate
                }
                if let departureDate = parameters.departureDate?.toDate() {
                    matches = matches && immigrant.departureDate == departureDate
                }
                if let shipName = parameters.shipName {
                    matches = matches && immigrant.shipName.localizedStandardContains(shipName)
                }
                if let prefectureName = parameters.prefectureName {
                    matches = matches && immigrant.prefectureName.localizedStandardContains(prefectureName)
                }
                
                return matches
            }
        )
        
        return dataBase.fetch(settings)
            .mapError { _ -> Error in
                ImmigrantError.couldntFindImmigrants
            }
            .eraseToAnyPublisher()
    }

    
    public func fetchImmigrants(_ byGroupId: Int) -> AnyPublisher<[ImmigrantOM], any Error> {
        let settings: FetchSettings<ImmigrantOM> = .init(
            predicate: #Predicate { $0.groupId == byGroupId }
        )
        
        return dataBase.fetch(settings)
            .mapError { _ -> Error in
                ImmigrantError.couldntFindImmigrants
            }
            .eraseToAnyPublisher()
    }
}

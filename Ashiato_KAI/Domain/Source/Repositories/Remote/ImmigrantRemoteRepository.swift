//
//  ImmigrantRemoteRepository.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 07/05/25.
//

import Combine
import Foundation

public struct ImmigrantRemoteRepository {
    let service: ImmigrantServiceInterface
    
    public init(_ env: NetworkEnvironment) {
        self.service = ImmigrantService(env)
    }
    
    // For unit testing purposes
    public init(_ service: ImmigrantServiceInterface) {
        self.service = service
    }
}


extension ImmigrantRemoteRepository: ImmigrantRepository {
    
    public func save(_ immigrant: ImmigrantOM) -> AnyPublisher<ImmigrantOM, any Error> {
        fatalError("Service not implemented!")
    }
    
    public func save(_ immigrants: [ImmigrantOM]) -> AnyPublisher<[ImmigrantOM], any Error> {
        fatalError("Service not implemented!")
    }
    
    public func fetchImmigrant(_ id: Int) -> AnyPublisher<ImmigrantOM?, Error> {
        let parameters = ImmigrantSearchDTO(immigrantId: id)
        
        return self.fetchImmigrants(parameters)
            .map { immigrants in
                immigrants.first { $0.immigrantId == id }
            }
            .eraseToAnyPublisher()
    }
    
    public func fetchImmigrants(_ parameters: ImmigrantSearchDTO) -> AnyPublisher<[ImmigrantOM], any Error> {
        service
            .getImmigrants(searchDTO: parameters)
            .mapModel()
            .eraseToAnyPublisher()
    }
    
    public func fetchImmigrants(_ groupId: Int) -> AnyPublisher<[ImmigrantOM], any Error> {
        
        let parameters = ImmigrantSearchDTO(groupId: groupId)
        
        return self.fetchImmigrants(parameters)
            .map { immigrants in
                immigrants.filter { $0.groupId == groupId }
            }
            .eraseToAnyPublisher()
    }
    
}

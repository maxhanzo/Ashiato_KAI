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
    
    public func fetchImmigrant(_ id: Int) -> AnyPublisher<ImmigrantOM?, any Error> {
        fatalError("Service not implemented!")
    }
    
    public func fetch(_ groupID: Int) -> AnyPublisher<[ImmigrantOM], any Error> {
        fatalError("Service not implemented!")
    }
    
    public func getImmigrant(_ parameters: ImmigrantSearchDTO) -> AnyPublisher<[ImmigrantOM], any Error> {
        service
            .getImmigrants(searchDTO: parameters)
            .mapModel()
            .eraseToAnyPublisher()
    }
    
    public func getImmigrants(_ groupID: Int) -> AnyPublisher<[ImmigrantOM], any Error> {
        do {
            let parameters = try ImmigrantSearchDTO(from: groupID as! Decoder)
            return service
                .getImmigrants(searchDTO: parameters)
                .mapModel()
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

}

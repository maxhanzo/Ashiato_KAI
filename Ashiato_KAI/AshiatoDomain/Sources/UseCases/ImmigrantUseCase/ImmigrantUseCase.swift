//
//  ImmigrantUseCase.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 08/05/25.
//

import Combine
import Foundation

public class ImmigrantUseCase {
    let local: ImmigrantLocalRepository
    let remote: ImmigrantRemoteRepository
    
    public init(
        _ environment: NetworkEnvironment,
        mocked: Bool = false
    ) {
        self.local = ImmigrantLocalRepository(mocked: mocked)
        self.remote = ImmigrantRemoteRepository(environment)
    }
    
    //For unit testing purposes
    public init(
        local: ImmigrantLocalRepository,
        remote: ImmigrantRemoteRepository,
        mocked: Bool = true
    ) {
        self.local = local
        self.remote = remote
    }
}

extension ImmigrantUseCase: ImmigrantUseCaseInterface {
    
    public func fetchImmigrant(_ byGroupId: Int) -> AnyPublisher<[ImmigrantOM], any Error> {
        let parameters = ImmigrantSearchDTO(groupId: byGroupId)
        return fetchImmigrants(parameters)
    }
 
    public func fetchImmigrants(_ parameters: ImmigrantSearchDTO) -> AnyPublisher<[ImmigrantOM], any Error> {
        local.fetchImmigrants(parameters)
            .catch { _ in self.remote.fetchImmigrants(parameters) }
            .flatMap { localOrRemoteResults -> AnyPublisher<[ImmigrantOM], any Error> in
                self.local.save(localOrRemoteResults)
                    .map { _ in localOrRemoteResults }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    public func fetchImmigrant(_ parameters: ImmigrantSearchDTO) -> AnyPublisher<ImmigrantOM?, any Error> {
        local.fetchImmigrants(parameters)
            .catch { _ in self.remote.fetchImmigrants(parameters) }
            .flatMap { localOrRemoteResults -> AnyPublisher<ImmigrantOM?, any Error> in
                self.local.save(localOrRemoteResults)
                    .map { _ in localOrRemoteResults.first }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

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

//extension ImmigrantUseCase: ImmigrantUseCaseInterface {
//    public func fetchImmigrant(_ parameters: ImmigrantSearchDTO) -> AnyPublisher<[ImmigrantOM], any Error> {
//        <#code#>
//    }
//    
//    public func fetchImmigrant(_ byGroupId: Int) -> AnyPublisher<[ImmigrantOM], any Error> {
//        <#code#>
//    }
//}

//
//  ImmigrantUseCaseInterface.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 08/05/25.
//

import Combine
import Foundation

public protocol ImmigrantUseCaseInterface {
    func fetchImmigrant(_ parameters: ImmigrantSearchDTO) -> AnyPublisher<[ImmigrantOM], any Error>
    func fetchImmigrant(_ byGroupId: Int) -> AnyPublisher<[ImmigrantOM], any Error>
}

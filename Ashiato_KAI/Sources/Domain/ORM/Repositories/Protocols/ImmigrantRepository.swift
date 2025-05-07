//
//  Untitled.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 07/05/25.
//

import Combine
import Foundation

public protocol ImmigrantRepository {
    func save(_ immigrant: ImmigrantOM) -> AnyPublisher<ImmigrantOM, any Error>
    func save(_ immigrants: [ImmigrantOM]) -> AnyPublisher<[ImmigrantOM], any Error>
    func getImmigrant(_ byID: Int) -> AnyPublisher<ImmigrantOM?, any Error>
    func getImmigrants(_ byGroupID: Int) -> AnyPublisher<[ImmigrantOM], any Error>
}

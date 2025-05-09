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
    func fetchImmigrant(_ id: Int) -> AnyPublisher<ImmigrantOM?, any Error>
    func fetchImmigrants(_ parameters: ImmigrantSearchDTO) -> AnyPublisher<[ImmigrantOM], any Error>
    func fetchImmigrants(_ groupID: Int) -> AnyPublisher<[ImmigrantOM], any Error>
}

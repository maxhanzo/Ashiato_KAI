//
//  ImmigrantServiceInterface.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 06/05/25.
//

import Combine

public protocol ImmigrantServiceInterface {
    func getImmigrants(searchDTO: ImmigrantSearchDTO) -> AnyPublisher<[ImmigrantDTO], any Error>
}

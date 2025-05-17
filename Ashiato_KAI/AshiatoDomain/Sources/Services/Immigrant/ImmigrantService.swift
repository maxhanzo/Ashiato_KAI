//
//  ImmigrantService.swift
//  Ashiato_KAI
//
//  Created by Max Ueda on 06/05/25.
//

import Combine

public class ImmigrantService: Service, ImmigrantServiceInterface {
    public func getImmigrants(searchDTO: ImmigrantSearchDTO) -> AnyPublisher<[ImmigrantDTO], any Error> {
        let target = ImmigrantProvider.getImmigrants(searchDTO)
        return client.perform(target, type: [ImmigrantDTO].self)
    }
}

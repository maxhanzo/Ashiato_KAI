//
//  HTTPClient.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation

public protocol HTTPClient {    
    func perform<T>(_ target: TargetProvider, type: T.Type) -> AnyPublisher<T, Error> where T: Decodable
    func download(_ target: TargetProvider) -> AnyPublisher<Data, Error>
}

//
//  SessionProviderInterface.swift
//  GGData
//
//  Created by UedaSoft IT Solutions on 08/05/25.
//

import Combine
import Foundation

public protocol SessionProviderInterface {
    var isLoggedIn: CurrentValueSubject<Bool, Never> { get }
    var token: String? { get }
    var refreshToken: String? { get }
    var expireIn: Date? { get }
    
    func updateSession() -> AnyPublisher<Void, Never>
    func sessionExpired() -> Bool
    func tokenPublisher() -> AnyPublisher<String, Error>
    func tokenPublisher(_ forceRefresh: Bool) -> AnyPublisher<String, Error>
    func refreshSessionPublisher() -> AnyPublisher<String, Error>
    func invalidateSessionPublisher() -> AnyPublisher<Bool, Never>
}

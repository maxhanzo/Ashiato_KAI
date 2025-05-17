//
//  TargetProvider.swift
//
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine
import Foundation

public protocol TargetProvider {
    var path: String? { get }
    var version: String? { get }
    var endpoint: String? { get }
    var method: HTTPMethod { get }
    var header: HTTPHeader? { get }
    var authorizationRequired: Bool { get }
    var task: HTTPTask { get }
}

public extension TargetProvider {
    var version: String? { nil }
    var authorizationRequired: Bool { true }
    var header: HTTPHeader? {
        .default
    }
    
    func urlRequestPublisher(for env: NetworkEnvironment, with sessionProvider: SessionProviderInterface?) -> AnyPublisher<URLRequest, Error> {
        Future { promise in
            var urlComponents = URLComponents()
            
            urlComponents.scheme = env.scheme
            urlComponents.host = env.host
            
            // Construct the path
            if let path, !path.isEmpty {
                urlComponents.path += "/\(path)"
            }
            
            if let version, !version.isEmpty {
                urlComponents.path += "/\(version)"
            }
            
            if let endpoint, !endpoint.isEmpty {
                urlComponents.path += "/\(endpoint)"
            }
            
            // Construct query items
            if case .requestURLEncodable(let parameters) = task {
                urlComponents.queryItems = parameters.compactMap { key, value -> URLQueryItem? in
                    if let values = value as? [Any], !values.isEmpty {
                        return values.map { URLQueryItem(name: key, value: "\($0)") }.first
                    } else {
                        return URLQueryItem(name: key, value: "\(value)")
                    }
                }
            }
            
            // Ensure URL creation is valid
            guard let url = urlComponents.url else {
                promise(.failure(NetworkError.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            // Add headers
            let httpHeader: HTTPHeader = header ?? .default
            httpHeader.addCustom(key: HTTPHeaderKey.subscription.rawValue, value: env.key)
            
            if authorizationRequired {
                let token = sessionProvider?.token ?? ""
                httpHeader.addAuthorization(token)
            }
            
            request.allHTTPHeaderFields = httpHeader.rawValue()
                
            // Add request body
            do {
                switch task {
                case .requestParameters(let parameters):
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                case .requestJSONEncodable(let encodable, let encoder):
                    request.httpBody = try encoder.encode(encodable)
                default:
                    break
                }
            } catch let error {
                promise(.failure(error))
                return
            }
        
            promise(.success(request))
        }
        .eraseToAnyPublisher()
    }
}

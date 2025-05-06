//
//  AnyPublisher+Async.swift
//  Ashiato_KAI
//
//  Created by UedaSoft IT Solutions on 06/05/25.
//

import Combine
import Foundation

public enum AsyncError: Error {
    case finishedWithoutValue
}

public extension AnyPublisher {
    func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            var finishedWithoutValue = true
            cancellable = first()
                .sink { completion in
                    switch completion {
                    case .finished:
                        if finishedWithoutValue {
                            continuation.resume(throwing: AsyncError.finishedWithoutValue)
                        }
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel()
                    cancellable = nil
                } receiveValue: { value in
                    finishedWithoutValue = false
                    continuation.resume(with: .success(value))
                }
        }
    }
}

public extension AnyPublisher where Output: Collection {
    func asyncStream(
        _ timeout: DispatchQueue.SchedulerTimeType.Stride = .seconds(5.0)
    ) async throws -> [Output.Element] {
        var result: [Output.Element] = []
        return try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            var finishedWithoutValue = true
            cancellable = subscribe(on: RunLoop.main)
                .timeout(
                    timeout,
                    scheduler: DispatchQueue.main
                )
                .sink { completion in
                    switch completion {
                    case .finished:
                        if finishedWithoutValue {
                            continuation.resume(throwing: AsyncError.finishedWithoutValue)
                        } else {
                            continuation.resume(with: .success(result))
                        }
                    case let .failure(error):
                        if finishedWithoutValue {
                            continuation.resume(throwing: error)
                        } else {
                            continuation.resume(with: .success(result))
                        }
                    }
                    cancellable?.cancel()
                    cancellable = nil
                } receiveValue: { values in
                    finishedWithoutValue = false
                    result.append(contentsOf: values)
                }
        }
    }
}

//
//  Publisher+Logger.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Combine

public extension Publisher {
    func log(
        prefix: LogPrefix = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        message: String = ""
    ) -> AnyPublisher<Self.Output, Self.Failure> {
        handleEvents(
            receiveOutput: { output in
                AKLogger.debug(
                    prefix: "[SUBSCRIPTION_OUTPUT] ◆ \(prefix: prefix)",
                    file: file,
                    function: function,
                    line: line,
                    message: message,
                    params: output
                )
            },
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    AKLogger.error(
                        prefix: "[SUBSCRIPTION_ERROR] ◆ \(prefix: prefix)",
                        file: file,
                        function: function,
                        line: line,
                        message: message,
                        params: (error as? (any ErrorMappable))?.debugDescription ?? error
                    )
                default:
                    break
                }
            }
        )
        .eraseToAnyPublisher()
    }
}

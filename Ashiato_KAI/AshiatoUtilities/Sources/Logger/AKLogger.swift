//
//  AKLogger.swift
//  Ashiato: KAI
//
//  Created by UedaSoft IT Solutions on 05/05/25.
//

import Foundation
import OSLog

public class AKLogger {
    static let shared: AKLogger = .init()
    let engine: Logger
    
    public init() {
        engine = .init()
    }
    
    public init(subsystem: String, category: String) {
        engine = .init(subsystem: subsystem, category: category)
    }
}

extension AKLogger {
    private static func buildLog(
        prefix: LogPrefix = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        level: LogLevel,
        message: String,
        params: Any?
    ) -> String {
        let timestamp = Date().formatted(date: .complete, time: .complete)
        let fileName = "\(file)".components(separatedBy: "/").last ?? ""
        let paramPrettyStr = JSONHelper.toPrettyJSONString(from: params ?? "")
        var fullString = "🕐 \(timestamp)"
        fullString += "\n📄 \(fileName):\(line) --> \(function)"
        fullString += "\n\(level.icon) [\(level.description)]"
        
        if !prefix.description.isEmpty {
            fullString += " :: \(prefix)"
        }
        
        if !message.isEmpty {
            fullString += " :: \(JSONHelper.toPrettyJSONString(from: message))"
        }
        
        if !paramPrettyStr.isEmpty {
            fullString += "\n\(paramPrettyStr)"
        }
        
        return fullString
    }
    
    public static func log(
        prefix: LogPrefix = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        message: String,
        params: Any? = nil
    ) {
        let messageFormatted = buildLog(
            prefix: prefix,
            file: file,
            function: function,
            line: line,
            level: .default,
            message: message,
            params: params
        )
        shared.engine.log("\(messageFormatted)")
    }
        
    public static func trace(
        prefix: LogPrefix = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        message: String,
        params: Any? = nil
    ) {
        let messageFormatted = buildLog(
            prefix: prefix,
            file: file,
            function: function,
            line: line,
            level: .trace,
            message: message,
            params: params
        )
        shared.engine.trace("\(messageFormatted)")
    }
    
    public static func debug(
        prefix: LogPrefix = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        message: String,
        params: Any? = nil
    ) {
        let messageFormatted = buildLog(
            prefix: prefix,
            file: file,
            function: function,
            line: line,
            level: .debug,
            message: message,
            params: params
        )
        shared.engine.debug("\(messageFormatted)")
    }
    
    public static func info(
        prefix: LogPrefix = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        message: String,
        params: Any? = nil
    ) {
        let messageFormatted = buildLog(
            prefix: prefix,
            file: file,
            function: function,
            line: line,
            level: .info,
            message: message,
            params: params
        )
        shared.engine.info("\(messageFormatted)")
    }
    
    public static func notice(
        prefix: LogPrefix = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        message: String,
        params: Any? = nil
    ) {
        let messageFormatted = buildLog(
            prefix: prefix,
            file: file,
            function: function,
            line: line,
            level: .notice,
            message: message,
            params: params
        )
        shared.engine.notice("\(messageFormatted)")
    }
    
    public static func warning(
        prefix: LogPrefix = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        message: String,
        params: Any? = nil
    ) {
        let messageFormatted = buildLog(
            prefix: prefix,
            file: file,
            function: function,
            line: line,
            level: .warning,
            message: message,
            params: params
        )
        shared.engine.warning("\(messageFormatted)")
    }
    
    public static func error(
        prefix: LogPrefix = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        message: String,
        params: Any? = nil
    ) {
        let messageFormatted = buildLog(
            prefix: prefix,
            file: file,
            function: function,
            line: line,
            level: .error,
            message: message,
            params: params
        )
        shared.engine.error("\(messageFormatted)")
    }
    
    public static func critical(
        prefix: LogPrefix = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        message: String,
        params: Any? = nil
    ) {
        let messageFormatted = buildLog(
            prefix: prefix,
            file: file,
            function: function,
            line: line,
            level: .critical,
            message: message,
            params: params
        )
        shared.engine.critical("\(messageFormatted)")
    }
    
    public static func fault(
        prefix: LogPrefix = "",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        message: String,
        params: Any? = nil
    ) {
        let messageFormatted = buildLog(
            prefix: prefix,
            file: file,
            function: function,
            line: line,
            level: .fault,
            message: message,
            params: params
        )
        shared.engine.fault("\(messageFormatted)")
    }
}

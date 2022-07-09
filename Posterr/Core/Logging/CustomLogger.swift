//
//  CustomLogger.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

final class CustomLogger {
    public static var shared = CustomLogger()

    private(set) var logs: [Log] = []

    private init() {
        // intentionally not implemented
    }

    public func log(message: String) {
        let log = Log(message: message)
        logs.insert(log, at: 0)
        print(log.description)
    }
}

struct Log: Identifiable, CustomStringConvertible {
    let id: String
    let message: String
    let time: String

    init(message: String) {
        self.message = message
        id = UUID().uuidString
        time = Date().format(with: .HHmm, locale: .current)
    }

    public var description: String { "\(time) - \(message)'" }
}


//
//  Loggable.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

protocol Loggable {
    // intentionally not implemented
}

extension Loggable {
    func log(_ message: String) {
        CustomLogger.shared.log(message: "\(String(describing: self)): \(message)")
    }
}

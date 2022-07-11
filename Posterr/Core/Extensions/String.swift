//
//  String.swift
//  Posterr
//
//  Created by Elton Jhony on 11.07.22.
//

import Foundation

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}

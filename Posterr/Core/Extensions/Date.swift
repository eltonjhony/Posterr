//
//  Date.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

extension Date {
    public enum Pattern: String {
        case HHmm = "HH:mm"
        case MMMMddyyyy = "MMMM dd, yyyy"
    }
    
    func format(with pattern: Pattern, locale: Locale = Locale(identifier: "en_US_POSIX")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = pattern.rawValue
        return dateFormatter.string(from: self)
    }
    
}

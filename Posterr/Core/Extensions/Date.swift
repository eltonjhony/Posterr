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
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        bySetting(hour: 23, minutes: 59, seconds: 59)
    }
    
    func format(with pattern: Pattern, locale: Locale = Locale(identifier: "en_US_POSIX")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = pattern.rawValue
        return dateFormatter.string(from: self)
    }
    
    func bySetting(hour: Int, minutes: Int, seconds: Int) -> Date {
        Calendar.current.date(bySettingHour: hour, minute: minutes, second: seconds, of: self) ?? self
    }
    
}

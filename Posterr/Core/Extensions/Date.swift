//
//  Date.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

extension Date {
    public enum Pattern: String {
        case ddMMyyyyhhmmssa = "dd/MM/yyyy hh:mm:ss a"
        case yyyyMMddHHmmssSssZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        case HHmm = "HH:mm"
        case yyyMMdd = "yyy-MM-dd"
        case yyyyMMdd = "yyyy-MM-dd"
        case EEEEddMMM = "EEEE, dd MMMM"
        case MMMMddyyyy = "MMMM dd, yyyy"
        case hhmma = "hh:mm a"
        case hhmm = "hh:mm"
        case dd = "dd"
        case ddMMMM = "dd MMMM"
        case ddMMyy = "dd/MM/yy"
    }
    
    func format(with pattern: Pattern = .ddMMyyyyhhmmssa, locale: Locale = Locale(identifier: "en_US_POSIX")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = pattern.rawValue
        return dateFormatter.string(from: self)
    }
    
}

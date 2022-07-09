//
//  Storable.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import RealmSwift

public protocol Storable {
    // Intentionally left empty
}

extension Object: Storable {
    // Intentionally left empty
}

public struct Sorted {
    var key: String
    var ascending: Bool = true
}

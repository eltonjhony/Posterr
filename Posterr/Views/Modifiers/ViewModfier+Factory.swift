//
//  ViewModfier+Factory.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

extension StyleModifier {
    static func navBar(title: String) -> StyleModifier<T> where T == NavBarModifier {
        .init(modifier: T(title: title))
    }
}

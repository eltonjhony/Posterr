//
//  ViewModfier+Factory.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation

typealias ActionCompletion = () -> Void

extension StyleModifier {
    static func navBar(title: String) -> StyleModifier<T> where T == NavBarModifier {
        .init(modifier: T(title: title))
    }
}

extension BehaviorModifier {
    static func touchable(disabled: Bool = false, _ action: @escaping ActionCompletion) -> BehaviorModifier<T> where T == Touchable {
        .init(modifier: T(disabled: disabled, action: action))
    }
}

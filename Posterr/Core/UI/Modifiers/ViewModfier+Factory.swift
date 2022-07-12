//
//  ViewModfier+Factory.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwiftUI

typealias ActionCompletion = () -> Void

extension StyleModifier {
    static func navBar(title: String) -> StyleModifier<T> where T == NavBarModifier {
        .init(modifier: T(title: title))
    }
    static func actionIcon(iconSize: CGFloat = 80) -> StyleModifier<T> where T == ActionIconModifier {
        .init(modifier: T(iconColor: .white, iconSize: iconSize))
    }
}

extension BehaviorModifier {
    static func touchable(disabled: Bool = false, _ action: @escaping ActionCompletion) -> BehaviorModifier<T> where T == Touchable {
        .init(modifier: T(disabled: disabled, action: action))
    }
}

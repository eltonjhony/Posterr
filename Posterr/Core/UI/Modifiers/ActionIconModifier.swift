//
//  ActionIconModifier.swift
//  Posterr
//
//  Created by Elton Jhony on 12.07.22.
//

import Foundation
import SwiftUI

struct ActionIconModifier: ViewModifier {
    let iconColor: Color
    let iconSize: CGFloat

    func body(content: Content) -> some View {
        Circle()
            .fill(iconColor)
            .frame(width: iconSize, height: iconSize, alignment: .center)
            .overlay(content)
    }
}

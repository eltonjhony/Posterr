//
//  Touchable.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

struct Touchable: ViewModifier {
    let action: ActionCompletion
    
    func body(content: Content) -> some View {
        Group {
            Button(action: action) {
                content
            }
        }
    }
}

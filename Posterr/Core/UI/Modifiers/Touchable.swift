//
//  Touchable.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

struct Touchable: ViewModifier {
    let disabled: Bool
    let action: ActionCompletion
    
    func body(content: Content) -> some View {
        Group {
            if disabled {
                content
            } else {
                Button(action: action) {
                    content
                }
            }
        }
    }
}

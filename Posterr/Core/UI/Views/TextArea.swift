//
//  TextArea.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwiftUI

struct TextArea: View {
    let placeholder: String
    @Binding var text: String
    
    @ViewBuilder
    var body: some View {
        ZStack(alignment: .top) {
            TextEditor(text: $text)
            HStack {
                if text.isBlank {
                    Text(placeholder)
                }
                Spacer()
            }
            .padding(.top, 4)
        }
    }
}

extension String {
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}

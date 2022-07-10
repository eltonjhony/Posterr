//
//  TextArea.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwiftUI

struct TextArea: View {
    enum FocusField: Hashable {
        case field
    }
    
    @FocusState var focusedField: FocusField?
    
    let placeholder: String
    @Binding var text: String
    
    @ViewBuilder
    var body: some View {
        ZStack(alignment: .top) {
            TextEditor(text: $text)
                .focused($focusedField, equals: .field)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.focusedField = .field
                    }
                }
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

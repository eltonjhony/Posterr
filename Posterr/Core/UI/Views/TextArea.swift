//
//  TextArea.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import AudioToolbox
import SwiftUI

struct TextArea: View {
    enum FocusField: Hashable {
        case field
    }
    
    @FocusState var focusedField: FocusField?
    
    let characterLimit: Int
    let placeholder: String
    @Binding var text: String
    
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
                        .fontWeight(.light)
                        .foregroundColor(.contentInverted)
                }
                Spacer()
            }
            .padding(.top, 4)
        }
        .onChange(of: text, perform: applyCharacterLimitValidation(_:))
    }
    
    private func applyCharacterLimitValidation(_ newValue: String) {
        if newValue.count > characterLimit {
            text = String(newValue.prefix(characterLimit))
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}

extension String {
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}

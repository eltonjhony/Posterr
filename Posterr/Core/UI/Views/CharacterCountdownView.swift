//
//  CharacterCountdownView.swift
//  Posterr
//
//  Created by Elton Jhony on 12.07.22.
//

import Foundation
import SwiftUI

struct CharacterCountdownView: View {
    var value: Double
    let maxCharacteres: Double
    
    private var percent: CGFloat {
        (value / maxCharacteres) * 100
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2.0)
                .opacity(0.3)
                .foregroundColor(.gray)

            Circle()
                .trim(from: 0, to: percent * 0.01)
                .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.appAccent)
                .rotationEffect(.init(
                    degrees: 270.0))
                .animation(.linear, value: value)
            
            Text("\(Int(value))")
                .font(.footnote)
        }
        .frame(width: 40, height: 40)
        .padding()
    }
    
}

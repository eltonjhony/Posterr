//
//  ProfilePictureView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwiftUI

struct ProfilePictureView: View {
    let picture: String?
    var size: CGFloat = 60
    
    var body: some View {
        VStack {
            Image(picture ?? "")
                .resizable()
                .scaledToFill()
                .clipped()
        }
        .frame(width: size, height: size, alignment: .center)
        .cornerRadius(80)
        .overlay(
            RoundedRectangle(cornerRadius: 80)
                .stroke(Color.white, lineWidth: 4)
        )
    }
}

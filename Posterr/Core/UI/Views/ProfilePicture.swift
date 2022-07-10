//
//  ProfilePicture.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwiftUI

struct ProfilePicture: View {
    let picture: String
    var size: CGFloat = 60
    
    var body: some View {
        Image(picture)
            .resizable()
            .frame(width: size, height: size)
            .cornerRadius(80)
    }
}

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
    
    var body: some View {
        Image(picture)
            .resizable()
            .frame(width: 60, height: 60)
            .cornerRadius(80)
    }
}

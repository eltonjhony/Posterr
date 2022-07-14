//
//  ProfileIdentificationView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwiftUI

struct ProfileIdentificationView: View {
    let username: String?
    
    var body: some View {
        Text(username ?? "")
            .fontWeight(.semibold)
            .foregroundColor(.contentInverted)
    }
}

//
//  RepostIdentificationView.swift
//  Posterr
//
//  Created by Elton Jhony on 13.07.22.
//

import Foundation
import SwiftUI

struct RepostIdentificationView: View {
    let username: String?
    var isFromCurrentUser: Bool = true
    
    private var identification: String {
        (isFromCurrentUser ? "Reposted by you" : "Repost from \(username ?? "")")
    }
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "repeat")
            Text(identification)
                .fontWeight(.semibold)
            Spacer()
        }
        .font(.footnote)
        .foregroundColor(.contentInverted)
        .padding(.horizontal)
    }
}

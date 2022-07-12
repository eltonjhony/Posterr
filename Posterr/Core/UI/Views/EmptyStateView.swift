//
//  EmptyStateView.swift
//  Posterr
//
//  Created by Elton Jhony on 12.07.22.
//

import Foundation
import SwiftUI

struct EmptyStateView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Image("emptyState")
            Text("No posts")
                .fontWeight(.semibold)
                .font(.headline)
            Text("Start creating your posts")
                .fontWeight(.semibold)
                .foregroundColor(.contentInverted)
            Spacer()
        }
    }
    
}

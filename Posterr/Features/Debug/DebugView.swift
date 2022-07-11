//
//  DebugView.swift
//  Posterr
//
//  Created by Elton Jhony on 11.07.22.
//

import Foundation
import SwiftUI

struct DebugView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Select the current user")
            ForEach(viewModel.users, id: \.uuid) { user in
                VStack(alignment: .leading) {
                    Text(user.username)
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding()
                .background(user.isCurrent ? Color.blue.opacity(0.4) : Color.white)
                .onTapGesture {
                    viewModel.select(new: user)
                }
            }
            Spacer()
        }
        .padding(.vertical)
        .onAppear(perform: viewModel.onAppear)
        .onChange(of: viewModel.dismiss) { newValue in
            presentationMode.wrappedValue.dismiss()
        }
    }
}

// MARK: Shake Detection
extension UIWindow {
    override open func becomeFirstResponder() -> Bool {
        true
    }

    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        let viewController = UIHostingController(rootView: DebugView(viewModel: PosterrAssembler.resolve(DebugView.ViewModel.self)))
        rootViewController?.present(viewController, animated: true)
    }
}

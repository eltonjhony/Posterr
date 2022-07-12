//
//  NotificationView.swift
//  Posterr
//
//  Created by Elton Jhony on 12.07.22.
//

import SwiftUI

struct NotificationView<Content>: View where Content: View {
    let data: NotificationDataModel
    var bottomPadding: CGFloat = 0

    @Binding var isShown: Bool

    var content: () -> Content
    
    var body: some View {
        if isShown {
            alert
        } else {
            content()
        }
    }

    private var alert: some View {
        ZStack(alignment: .top) {
            content()
            Color.clear.blur(radius: 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    guard data.onCancel == nil else { return }
                    dismiss()
                }
            toast.padding(.horizontal)
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    private var toast: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(data.image)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: .iconDimension, height: .iconDimension, alignment: .center)
                .foregroundColor(.appPrimary)
                .style(.actionIcon(iconSize: .iconContainerDimension))

            Text(data.message)
                .fontWeight(.semibold)

            Spacer()
            Button(action: dismiss) {
                Image("clearIcon")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .frame(width: .closeImageDimension, height: .closeImageDimension, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .background(Color.appAccent)
        .cornerRadius(.toastRadius)
        .animation(.easeInOut, value: 0)
        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
    }

    private func dismiss() {
        withAnimation { isShown = false }
    }
}

private extension CGFloat {
    static let closeImageDimension: CGFloat = 16
    static let toastRadius: CGFloat = 16
    static let iconContainerDimension: CGFloat = 24
    static let iconDimension: CGFloat = 14
}


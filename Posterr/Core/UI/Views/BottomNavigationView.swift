//
//  BottomNavigationView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

protocol NavTab {
    var image: String { get }
    var index: Int { get }
    var view: AnyView { get }
}

struct BottomNavigationView: View {
    let tabs: [NavTab]
    @Binding var selectedTab: Int

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                ForEach(tabs, id: \.index) { tab in
                    tab.view.padding(.bottom)
                }
            }
            customTabBar
                .shadow(radius: 4)
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    private var customTabBar: some View {
        HStack(alignment: .bottom, spacing: 8) {
            ForEach(tabs, id: \.index) { tab in
                Spacer()
                Button(
                    action: { selectedTab = tab.index },
                    label: {
                        VStack(spacing: 8) {
                            Image(tab.image)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(selectedTab == tab.index ? .appPrimary : .contentInverted)
                                .padding(.top, 16)
                                .frame(width: 45, height: 45)
                        }
                    }
                )
                Spacer()
            }
        }
        .frame(height: .tabBarHeight)
        .padding(.bottom, max(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0, 8))
        .background(Color.white)
        .cornerRadius(32, corners: [.topLeft, .topRight])
    }

}

extension CGFloat {
    static let tabBarHeight: CGFloat = 60
}

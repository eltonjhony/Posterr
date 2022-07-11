//
//  TabBarItems.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwiftUI

enum TabBarItems: Int {
    case home, profile
}

struct HomeTab: NavTab {
    let image = "homeIcon"
    let index = TabBarItems.home.rawValue
    let view: AnyView

    init(view: HomeView) {
        self.view = AnyView(view)
    }
}

struct ProfileTab: NavTab {
    let image = "profileIcon"
    let index = TabBarItems.profile.rawValue
    let view: AnyView

    init(view: ProfileView) {
        self.view = AnyView(view)
    }
}

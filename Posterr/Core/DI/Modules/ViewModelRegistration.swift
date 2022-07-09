//
//  ViewModelRegistration.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwinjectAutoregistration

final class ViewModelRegistration: PosterrAssembly {
    func assemble(container: PosterrContainer) {
        container.autoregister(AddPostView.ViewModel.self, initializer: AddPostView.ViewModel.init)
        container.autoregister(HomeView.ViewModel.self, initializer: HomeView.ViewModel.init)
        container.autoregister(ProfileView.ViewModel.self, initializer: ProfileView.ViewModel.init)
        
        container.register(TabBarView.ViewModel.self) { resolver in
            let homeTab: HomeTab = .init(view: container~>)
            let profileTab: ProfileTab = .init(view: container~>)
            return TabBarView.ViewModel.init(tabs: [homeTab, profileTab], selectedTab: homeTab.index)
        }
    }
}

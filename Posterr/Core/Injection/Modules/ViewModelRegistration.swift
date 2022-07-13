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
        container.autoregister(AddPostView.ViewModel.self, argument: SubmissionType.self) { argument in
            AddPostView.ViewModel(type: argument, userRepository: container~>, usecase: container~>)
        }
        container.autoregister(HomeView.ViewModel.self, initializer: HomeView.ViewModel.init)
        container.autoregister(ProfileView.ViewModel.self, initializer: ProfileView.ViewModel.init)
        container.autoregister(DebugView.ViewModel.self, initializer: DebugView.ViewModel.init)
        
        container.register(TabBarView.ViewModel.self) { resolver in
            let homeTab: HomeTab = .init(view: container~>)
            let profileTab: ProfileTab = .init(view: container~>)
            return TabBarView.ViewModel.init(tabs: [homeTab, profileTab], selectedTab: homeTab.index)
        }
        
        container.autoregister(PostRowView.ViewModel.self, argument: PostItem.self) { argument in
            PostRowView.ViewModel(item: argument, usecase: container~>)
        }
    }
}

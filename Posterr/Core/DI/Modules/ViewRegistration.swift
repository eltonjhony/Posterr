//
//  ViewRegistration.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwinjectAutoregistration

final class ViewRegistration: PosterrAssembly {

    func assemble(container: PosterrContainer) {
        container.autoregister(AddPostView.self, initializer: AddPostView.init)
        container.autoregister(HomeView.self, initializer: HomeView.init)
        container.autoregister(ProfileView.self, initializer: ProfileView.init)
        container.autoregister(TabBarView.self, initializer: TabBarView.init)
    }
    
}

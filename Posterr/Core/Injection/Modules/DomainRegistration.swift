//
//  DomainRegistration.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwinjectAutoregistration

final class DomainRegistration: PosterrAssembly {
    func assemble(container: PosterrContainer) {
        container.autoregister(UserRegistrable.self, initializer: UserRegistrableUseCase.init).inObjectScope(.container)
        container.autoregister(PostUpdatable.self, initializer: PostUpdatableUseCase.init).inObjectScope(.container)
        container.autoregister(ProfileInfoFetchable.self, initializer: ProfileInfoFetchableUseCase.init).inObjectScope(.container)
        container.autoregister(FeedFetchable.self, initializer: FeedFetchableUseCase.init).inObjectScope(.container)
    }
}

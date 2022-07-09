//
//  DatasourceRegistration.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwinjectAutoregistration

/// Registration names to be used during DI registration and resolution of BeesDatasource types.
public enum ProviderTypeRegistration: String {
    case memory
    case remote
    case database
}

final class DatasourceRegistration: PosterrAssembly {
    func assemble(container: PosterrContainer) {
        container.autoregister(
            UserProvider.self,
            name: ProviderTypeRegistration.database.rawValue,
            initializer: UserRealmProvider.init
        )
        
        container.autoregister(UserRepository.self) { argument in
            guard let localProvider = container.resolve(UserProvider.self, name: ProviderTypeRegistration.database.rawValue) else {
                fatalError("Unable to resolve any implementation for \(UserProvider.self)")
            }
            return DefaultUserRepository(provider: localProvider)
        }
    }
}

//
//  CoreRegistration.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import Foundation
import SwinjectAutoregistration

final class CoreRegistration: PosterrAssembly {
    func assemble(container: PosterrContainer) {
        container.register(DBManager.self) { _ in
            RealmDBManager(RealmProvider.default)
        }.inObjectScope(.container)
    }
}

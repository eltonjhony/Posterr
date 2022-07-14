//
//  AppDelegate.swift
//  Posterr
//
//  Created by Elton Jhony on 14.07.22.
//

import Foundation
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        initializeApplicationContainer()
        setupUsers()
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        if connectingSceneSession.role == .windowApplication {
            configuration.delegateClass = SceneDelegate.self
        }
        return configuration
    }
    
    private func initializeApplicationContainer() {
        let registrations: [PosterrAssembly] = [
            ViewRegistration(),
            ViewModelRegistration(),
            DomainRegistration(),
            DatasourceRegistration(),
            CoreRegistration()
        ]
        PosterrAssembler.apply(registrations)
    }
    
    private func setupUsers() {
        let usecase = PosterrAssembler.resolve(UserRegistrable.self)
        usecase.register()
    }
}

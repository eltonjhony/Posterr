//
//  PosterrApp.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        initializeApplicationContainer()
        setupUsers()
        return true
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

@main
struct PosterrApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            PosterrAssembler.resolve(TabBarView.self)
        }
    }
}

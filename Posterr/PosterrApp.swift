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
        return true
    }
    
    private func initializeApplicationContainer() {
        let registrations: [PosterrAssembly] = [
            ViewRegistration(),
            ViewModelRegistration()
        ]
        PosterrAssembler.apply(registrations)
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

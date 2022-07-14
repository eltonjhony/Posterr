//
//  PosterrApp.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

@main
struct PosterrApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            PosterrAssembler.resolve(TabBarView.self)
        }
    }
}

//
//  SceneDelegate.swift
//  Posterr
//
//  Created by Elton Jhony on 14.07.22.
//

import Foundation
import SwiftUI

final class SceneDelegate: NSObject, ObservableObject, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = windowScene.keyWindow   // << store !!!
    }
}

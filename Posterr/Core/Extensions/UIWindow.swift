//
//  UIWindow.swift
//  Posterr
//
//  Created by Elton Jhony on 14.07.22.
//

import Foundation
import UIKit

extension UIWindow {
        
    var statusBarHeight: CGFloat? {
        windowScene?.statusBarManager?.statusBarFrame.height
    }
    
}

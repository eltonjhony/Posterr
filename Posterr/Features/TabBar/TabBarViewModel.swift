//
//  TabBarViewModel.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

extension TabBarView {
    
    class ViewModel: ObservableObject {
        
        @Published private(set) var tabs: [NavTab]
        @Published var selectedTab: Int
        
        init(tabs: [NavTab], selectedTab: Int) {
            self.tabs = tabs.sorted { $0.index < $1.index }
            self.selectedTab = selectedTab
        }
    }
    
}

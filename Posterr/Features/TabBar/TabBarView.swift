//
//  TabBarView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        BottomNavigationView(tabs: viewModel.tabs, selectedTab: $viewModel.selectedTab)
    }

}

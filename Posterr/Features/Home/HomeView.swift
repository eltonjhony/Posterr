//
//  HomeView.swift
//  Posterr
//
//  Created by Elton Jhony on 09.07.22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        content
            .style(.navBar(title: "Posterr Feed"))
            .edgesIgnoringSafeArea(.bottom)
    }
        
    @ViewBuilder
    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                timeline
            }
        }
    }
    
    private var timeline: some View {
        ForEach(viewModel.posts, id: \.uuid) { post in
            PostView(post: post) {
                viewModel.repost(post)
            } onQuote: {
                viewModel.quote(post)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return HomeView(viewModel: .init())
    }
}

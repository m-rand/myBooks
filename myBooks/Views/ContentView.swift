//
//  ContentView.swift
//  Shared
//
//  Created by Marcel Baláš on 26.01.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: Tab = .discover
    @StateObject var searchTitleViewModel = SearchTitleViewModel()
    @StateObject var subjectViewModel = SubjectViewModel()
    
    enum Tab {
        case discover
        case searchTitle
    }
    
    var body: some View {
        TabView(selection: $selection) {
            DiscoverView(viewModel: subjectViewModel)
            .tabItem {
                Label("Discover", systemImage: "eye.circle")
            }
            .tag(Tab.discover)
            
            SearchView(viewModel: searchTitleViewModel)
            .tabItem {
                Label("Search", systemImage: "magnifyingglass.circle")
            }
            .tag(Tab.searchTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

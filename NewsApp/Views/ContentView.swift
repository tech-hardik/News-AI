//
//  ContentView.swift
//  NewsApp
//
//  Created by alex on 5/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            NewsView()
                .tag(1)
            
            SearchView()
                .tag(2)
            
            SettingsView()
                .tag(3)
        }
        .overlay(alignment: .bottom) {
            CustomTabView(tabSelection: $tabSelection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 23.06.2024.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var selectedTab = 0
    @State private var showModal = false
    @State private var date = Date()
    @State private var time = Date()
    @State private var title = ""
    @State private var description = ""

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }.tag(0)
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }.tag(1)
                
                SettingsView().environmentObject(userManager)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }.tag(2)
            }
        }
    }
}

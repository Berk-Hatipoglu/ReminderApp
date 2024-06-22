//
//  SettingsView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 24.06.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userManager: UserManager
    @StateObject private var settingsViewModel = SettingsViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink(destination: UserInfoView()) {
                        Text("Account Info")
                    }
                    
                    Toggle(isOn: $settingsViewModel.isDarkMode) {
                        HStack {
                            Text("Appearance")
                            Spacer()
                            Image(systemName: settingsViewModel.isDarkMode ? "moon.fill" : "sun.max.fill")
                                .foregroundColor(settingsViewModel.isDarkMode ? .yellow : .blue)
                        }
                    }
                     
                    Button(action: { settingsViewModel.logout(userManager: userManager) }) {
                        Text("Sign Out")
                            .foregroundColor(.red)
                    }
                    .padding(.top, 50)
                }
                .navigationTitle("Settings")
            }
        }
        .preferredColorScheme(settingsViewModel.isDarkMode ? .dark : .light)
    }
}

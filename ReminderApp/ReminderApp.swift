//
//  toDoAppApp.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 23.06.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ReminderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userManager = UserManager()
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if userManager.isUserLoggedIn {
                    ContentView().environmentObject(userManager) .preferredColorScheme(isDarkMode ? .dark : .light)
                } else {
                    OnboardingSliderView().environmentObject(userManager) .preferredColorScheme(isDarkMode ? .dark : .light)
                }
            }
        }
    }
}

//
//  SettingsInfoViewModel.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 24.06.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

class SettingsViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var errorMessage = ""
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    func logout(userManager: UserManager) {
        do {
            try Auth.auth().signOut()
            userManager.logoutUser()
            DispatchQueue.main.async {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = UIHostingController(rootView: LoginView().environmentObject(userManager))
                    window.makeKeyAndVisible()
                }
            }
            print("Log off user: \(userManager.userId) Log off status: \(userManager.isUserLoggedIn)")
        } catch {
            errorMessage = "Oturum kapatma hatası: \(error.localizedDescription)"
            print(errorMessage)
        }
    }
}

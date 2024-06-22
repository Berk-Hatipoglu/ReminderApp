//
//  UserManager.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 23.06.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

class UserManager: ObservableObject {
    
    @Published var isUserLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isUserLoggedIn, forKey: "isUserLoggedIn")
        }
    }
    @Published var userId: String {
        didSet {
            UserDefaults.standard.set(userId, forKey: "userId")
        }
    }
    
    @Published var shouldNavigateToLogin: Bool = false
        
    init() {
        self.isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        self.userId = UserDefaults.standard.string(forKey: "userId") ?? ""
    }

    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard error == nil else {
                print("Login error: \(error!.localizedDescription)")
                return
            }
            self?.isUserLoggedIn = true
            self?.userId = result?.user.uid ?? ""
            self?.fetchUserInfo()
        }
    }

    func fetchUserInfo() {
        guard let currentUser = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(currentUser.uid)

        docRef.getDocument { [weak self] document, error in
            if let document = document, document.exists {
                _ = document.data()
                self?.userId = document.documentID
            } else {
                print("Document does not exist")
            }
        }
    }

    func logoutUser() {
        do {
            try Auth.auth().signOut()
            self.isUserLoggedIn = false
            self.userId = ""
            UserDefaults.standard.removeObject(forKey: "userId")
            UserDefaults.standard.set(false, forKey: "isDarkMode")
            UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        } catch let signOutError as NSError {
            print("Logout error: \(signOutError.localizedDescription)")
        }
    }
}

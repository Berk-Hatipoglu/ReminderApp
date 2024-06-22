//
//  LoginViewModel.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 23.06.2024.
//

import Foundation
import Firebase
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var name = ""
    @Published var surname = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var screenMessage = ""
    @Published var isUserLoggedIn = false
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.screenMessage = error.localizedDescription
                }
                return
            }
            
            guard let user = result?.user else { return }
            let db = Firestore.firestore()
            let docRef = db.collection("users").document(user.uid)
            
            docRef.getDocument { document, error in
                if let document = document, document.exists {
                    let data = document.data()
                    
                    let id = document.documentID
                    let name = data?["name"] as? String ?? ""
                    let surname = data?["surname"] as? String ?? ""
                    let username = data?["username"] as? String ?? ""
                    let email = data?["email"] as? String ?? ""
                    
                    UserDefaults.standard.set(id, forKey: "userId")
                    
                    DispatchQueue.main.async {
                        self?.name = name
                        self?.surname = surname
                        self?.username = username
                        self?.email = email
                        self?.isUserLoggedIn = true
                        self?.screenMessage = "User logged in successfully"
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.screenMessage = "Check Your Credentials and Try Again"
                    }
                }
            }
        }
    }
}


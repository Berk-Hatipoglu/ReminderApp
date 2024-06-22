//
//  SignUpViewModel.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 23.06.2024.
//

import Foundation
import Firebase
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    @Published var name = ""
    @Published var surname = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var screenMessage = ""
    @Published var isUserSignedUp = false
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                self.screenMessage = error.localizedDescription
                return
            }

            guard let uid = result?.user.uid else {
                print("Failed to get user ID")
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users").document(uid).setData([
                "id": uid,
                "username": self.username,
                "name": self.name,
                "surname": self.surname,
                "email": self.email
            ]) { error in
                if let error = error {
                    print("Error saving user data: \(error.localizedDescription)")
                    self.screenMessage = "Error saving user data"
                } else {
                    DispatchQueue.main.async {
                        print("User signed up successfully. Email: \(self.email)")
                        self.screenMessage = "User signed up successfully"
                        self.isUserSignedUp = true
                    }
                }
            }
        }
    }
}

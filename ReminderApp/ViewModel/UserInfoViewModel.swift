//
//  UserInfoViewModel.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 24.06.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserInfoViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var username: String = ""
    @Published var email: String = ""
    
    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var passwordChangeMessage: String = ""
    
    @Published var user = User(id: 0, name: "", surname: "", username: "", email: "", password: "")
    
    private var db = Firestore.firestore()
    
    init() {
        fetchUserInfo()
    }
    
    func fetchUserInfo() {
        if let currentUser = Auth.auth().currentUser {
            let userId = currentUser.uid
            db.collection("users").whereField("id", isEqualTo: userId).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    if let document = querySnapshot?.documents.first {
                        let data = document.data()
                        self.user = User(
                            id: data["id"] as? Int ?? 0,
                            name: data["name"] as? String ?? "",
                            surname: data["surname"] as? String ?? "",
                            username: data["username"] as? String ?? "",
                            email: data["email"] as? String ?? "",
                            password: data["password"] as? String ?? ""
                        )
                    }
                }
            }
        }
    }
    
    func updateUserInfo(_ updatedUser: User) {
        if let user = Auth.auth().currentUser {
            db.collection("users").whereField("id", isEqualTo: user.uid).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    if let document = querySnapshot?.documents.first {
                        let documentID = document.documentID
                        self.db.collection("users").document(documentID).updateData([
                            "name": updatedUser.name,
                            "surname": updatedUser.surname,
                            "username": updatedUser.username,
                            "email": updatedUser.email
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated")
                                self.user = updatedUser // Güncellenmiş kullanıcıyı yerel olarak da güncelle
                            }
                        }
                    }
                }
            }
        }
    }
    
    func changePassword() {
        guard let user = Auth.auth().currentUser else {
            self.passwordChangeMessage = "User not logged in."
            return
        }
        
        if newPassword != confirmPassword {
            self.passwordChangeMessage = "New passwords do not match."
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: oldPassword)
        
        user.reauthenticate(with: credential) { result, error in
            if error != nil {
                self.passwordChangeMessage = "Incorrect old password."
                return
            }
            
            user.updatePassword(to: self.newPassword) { error in
                if let error = error {
                    self.passwordChangeMessage = "Failed to update password: \(error.localizedDescription)"
                } else {
                    self.passwordChangeMessage = "Password successfully updated."
                }
            }
        }
    }
}


/*

import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserInfoViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var username: String = ""
    @Published var email: String = ""
    
    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var passwordChangeMessage: String = ""
    
    private var db = Firestore.firestore()
    
    init() {
        fetchUserInfo()
    }
    
    func fetchUserInfo() {
        if let user = Auth.auth().currentUser {
            self.email = user.email ?? ""
            db.collection("users").whereField("email", isEqualTo: self.email).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    if let document = querySnapshot?.documents.first {
                        let data = document.data()
                        self.name = data["name"] as? String ?? ""
                        self.surname = data["surname"] as? String ?? ""
                        self.username = data["username"] as? String ?? ""
                    }
                }
            }
        }
    }
    
    func saveUserInfo() {
        if let user = Auth.auth().currentUser {
            db.collection("users").whereField("email", isEqualTo: user.email ?? "").getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    if let document = querySnapshot?.documents.first {
                        let documentID = document.documentID
                        self.db.collection("users").document(documentID).updateData([
                            "name": self.name,
                            "surname": self.surname,
                            "username": self.username
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func changePassword() {
        guard let user = Auth.auth().currentUser else {
            self.passwordChangeMessage = "User not logged in."
            return
        }
        
        if newPassword != confirmPassword {
            self.passwordChangeMessage = "New passwords do not match."
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: oldPassword)
        
        user.reauthenticate(with: credential) { result, error in
            if error != nil {
                self.passwordChangeMessage = "Incorrect old password."
                return
            }
            
            user.updatePassword(to: self.newPassword) { error in
                if let error = error {
                    self.passwordChangeMessage = "Failed to update password: \(error.localizedDescription)"
                } else {
                    self.passwordChangeMessage = "Password successfully updated."
                }
            }
        }
    }
}

*/

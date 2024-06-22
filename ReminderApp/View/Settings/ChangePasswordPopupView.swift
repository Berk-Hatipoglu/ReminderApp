//
//  ChangePasswordPopupView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 13.07.2024.
//

import SwiftUI
import FirebaseAuth

struct ChangePasswordPopupView: View {
    @Binding var isPresented: Bool
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    customSecureTextField(title: "Enter current password", text: $currentPassword)
                    customSecureTextField(title: "Enter new password", text: $newPassword)
                    customSecureTextField(title: "Re-enter new password", text: $confirmPassword)
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 5)
                }
            }
            .navigationBarTitle("Change Password", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    isPresented.toggle()
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                    changePassword()
                }) {
                    Text("Save")
                }
            )
        }
    }
    
    private func changePassword() {
        guard !currentPassword.isEmpty, !newPassword.isEmpty, newPassword == confirmPassword else {
            errorMessage = "Please make sure all fields are filled in correctly and the new passwords match."
            return
        }
        
        // Authenticate user
        Auth.auth().signIn(withEmail: Auth.auth().currentUser?.email ?? "", password: currentPassword) { authResult, error in
            if let error = error {
                errorMessage = "Current password is incorrect: \(error.localizedDescription)"
                return
            }
            
            // Update password
            Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
                if let error = error {
                    errorMessage = "Failed to update password: \(error.localizedDescription)"
                } else {
                    errorMessage = "Password successfully updated"
                    isPresented.toggle()
                }
            }
        }
    }
}

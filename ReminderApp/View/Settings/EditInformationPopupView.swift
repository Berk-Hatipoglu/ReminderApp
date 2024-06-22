//
//  EditInformationPopupView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 13.07.2024.
//

import SwiftUI

struct EditInformationPopupView: View {
    @Binding var isPresented: Bool
    @Binding var user: User
    var onSave: (User) -> Void
    
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var username: String = ""
    @State private var email: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Information")) {
                    customTextField(title: "Name", text: $name)
                    customTextField(title: "Surname", text: $surname)
                    customTextField(title: "Username", text: $username)
                    customTextField(title: "Email", text: $email)
                }
            }
            .navigationBarTitle("Edit Information", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    isPresented.toggle()
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                    let updatedUser = User(id: user.id, name: name, surname: surname, username: username, email: email, password: user.password)
                    onSave(updatedUser)
                    isPresented.toggle()
                }) {
                    Text("Save")
                }
            )
            .onAppear {
                self.name = user.name
                self.surname = user.surname
                self.username = user.username
                self.email = user.email
            }
        }
    }
}

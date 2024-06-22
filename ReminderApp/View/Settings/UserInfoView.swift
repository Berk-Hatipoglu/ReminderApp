//
//  UserInfoView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 24.06.2024.
//

import SwiftUI

struct UserInfoView: View {
    @ObservedObject var userInfoViewModel = UserInfoViewModel()
    @State private var showEditInformationPopup = false
    @State private var showChangePasswordPopup = false
    @State private var editingUser = User(id: 0, name: "", surname: "", username: "", email: "", password: "")

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("User Information")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                VStack(alignment: .leading, spacing: 15) {
                    UserInfoRow(label: "Name", value: userInfoViewModel.user.name)
                    UserInfoRow(label: "Surname", value: userInfoViewModel.user.surname)
                    UserInfoRow(label: "Username", value: userInfoViewModel.user.username)
                    UserInfoRow(label: "Email", value: userInfoViewModel.user.email)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .padding(.horizontal, 10)
            }
            .padding()
            .onAppear {
                userInfoViewModel.fetchUserInfo()
            }
            
            Spacer().frame(height: 50)
            
            VStack(spacing: 15) {
                Button(action: {
                    editingUser = userInfoViewModel.user
                    showEditInformationPopup = true
                }) {
                    Text("Edit Information")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    showChangePasswordPopup = true
                }) {
                    Text("Change Password")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 40)
            .sheet(isPresented: $showEditInformationPopup) {
                EditInformationPopupView(isPresented: $showEditInformationPopup, user: $editingUser, onSave: { updatedUser in
                    userInfoViewModel.updateUserInfo(updatedUser)
                })
            }
            .sheet(isPresented: $showChangePasswordPopup) {
                ChangePasswordPopupView(isPresented: $showChangePasswordPopup)
            }
        }
    }
}

struct UserInfoRow: View {
    var label: String
    var value: String

    var body: some View {
        HStack {
            Text("\(label):")
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 5)
        .overlay(
            Divider().background(Color.gray),
            alignment: .bottom
        )
    }
}

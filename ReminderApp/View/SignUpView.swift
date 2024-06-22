//
//  SignUpView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 23.06.2024.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @EnvironmentObject var userManager: UserManager
    @State private var showPassword = false
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)

                    VStack(spacing: 15) {
                        customHeaderTextField(title: "Name", text: $viewModel.name)
                        customHeaderTextField(title: "Surname", text: $viewModel.surname)
                        customHeaderTextField(title: "Username", text: $viewModel.username)
                        customHeaderTextField(title: "Email", text: $viewModel.email)
                        customHeaderSecureFieldWithEye(title: "Password", text: $viewModel.password, showPassword: $showPassword)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10.0)
                    .shadow(radius: 10)
                    .padding(.horizontal, 20)

                    Button(action: viewModel.signUp) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10.0)
                            .padding(.horizontal, 20)
                    }
                    .navigationDestination(isPresented: $viewModel.isUserSignedUp) {
                        LoginView().environmentObject(userManager).navigationBarBackButtonHidden(true)
                    }
                    .padding(.top, 20)

                    Text(viewModel.screenMessage)
                        .foregroundColor(.white)
                        .padding()

                    NavigationLink(destination: LoginView().environmentObject(userManager).navigationBarBackButtonHidden(true)){
                        Text("Already have an account? Log in")
                    }
                }
            }
        }
    }
}

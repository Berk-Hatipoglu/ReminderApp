//
//  LoginView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 23.06.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var userManager: UserManager
    @State private var showPassword = false

    var body: some View {
        NavigationStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Log In")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    VStack(spacing: 15) {
                        customHeaderTextField(title: "Email", text: $viewModel.email)
                        customHeaderSecureFieldWithEye(title: "Password", text: $viewModel.password, showPassword: $showPassword)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10.0)
                    .shadow(radius: 10)
                    .padding(.horizontal, 20)
                    
                    Button(action: viewModel.login) {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10.0)
                            .padding(.horizontal, 20)
                    }
                    .navigationDestination(isPresented: $userManager.isUserLoggedIn) {
                        ContentView().environmentObject(userManager).navigationBarBackButtonHidden(true)
                    }
                    .padding(.top, 20)
                    
                    Text(viewModel.screenMessage)
                        .foregroundColor(.white)
                        .padding()
                    
                    NavigationLink(destination: SignUpView().environmentObject(userManager).navigationBarBackButtonHidden(true)){
                        Text("Don't you have an account? Sign in")
                    }
                }
            }
            .onChange(of: viewModel.isUserLoggedIn) {
                if viewModel.isUserLoggedIn {
                    userManager.userId = Auth.auth().currentUser?.uid ?? ""
                    userManager.isUserLoggedIn = viewModel.isUserLoggedIn
                    print("UserManager userId: \(userManager.userId) UserManager is logged: \(userManager.isUserLoggedIn)")
                }
            }
        }
    }
}

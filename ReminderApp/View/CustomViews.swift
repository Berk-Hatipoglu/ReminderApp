//
//  CustomViews.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 23.06.2024.
//

import SwiftUI

extension View {
    func customHeaderTextField(title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
            
            HStack {
                TextField("", text: text)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(5.0)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                if !text.wrappedValue.isEmpty {
                    Button(action: {
                        text.wrappedValue = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 10)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 3.0)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
        .padding(.bottom, 5)
    }
 
    func customTextField(title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(.subheadline)
                .padding(.bottom, 2)
            HStack {
                TextField("", text: text)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(3.0)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                if !text.wrappedValue.isEmpty {
                    Button(action: {
                        text.wrappedValue = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 3.0)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
        }
        .padding(.bottom, 3)
    }
    
    
    func customHeaderSecureTextField(title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
            
            HStack {
                SecureField("", text: text) 
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .cornerRadius(5.0)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                if !text.wrappedValue.isEmpty {
                    Button(action: {
                        text.wrappedValue = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 10)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 5.0)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
        .padding(.bottom, 5)
    }
  
    func customSecureTextField(title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(.subheadline)
                .padding(.bottom, 2)
            HStack {
                SecureField("", text: text)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
                    .cornerRadius(3.0)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                if !text.wrappedValue.isEmpty {
                    Button(action: {
                        text.wrappedValue = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 3.0)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
        }
        .padding(.bottom, 3)
    }
 
    
    func customSecureFieldWithEye(title: String, text: Binding<String>, showPassword: Binding<Bool>) -> some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .padding(.bottom, 2)
            HStack {
                if showPassword.wrappedValue {
                    TextField("", text: text)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(3.0)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .overlay(
                            Button(action: {
                                showPassword.wrappedValue.toggle()
                            }) {
                                Image(systemName: showPassword.wrappedValue ? "eye.slash.fill" : "eye.fill")
                                    .padding(.trailing, 10)
                            }, alignment: .trailing
                        )
                } else {
                    SecureField(title, text: text)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(3.0)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .overlay(
                            Button(action: {
                                showPassword.wrappedValue.toggle()
                            }) {
                                Image(systemName: showPassword.wrappedValue ? "eye.slash.fill" : "eye.fill")
                                    .padding(.trailing, 10)
                            }, alignment: .trailing
                        )
                }
            }
        }
    }
    
    
    func customHeaderSecureFieldWithEye(title: String, text: Binding<String>, showPassword: Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
            
            HStack {
                if showPassword.wrappedValue {
                    TextField("", text: text)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color(.systemGray6))
                        .background(RoundedRectangle(cornerRadius: 5.0).stroke(Color.gray, lineWidth: 1))
                        .cornerRadius(5.0)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .overlay(
                            Button(action: {
                                showPassword.wrappedValue.toggle()
                            }) {
                                Image(systemName: showPassword.wrappedValue ? "eye.slash.fill" : "eye.fill")
                                    .padding(.trailing, 10)
                            }, alignment: .trailing
                        )
                } else {
                    SecureField("", text: text)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color(.systemGray6))
                        .cornerRadius(5.0)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        .overlay(
                            Button(action: {
                                showPassword.wrappedValue.toggle()
                            }) {
                                Image(systemName: showPassword.wrappedValue ? "eye.slash.fill" : "eye.fill")
                                    .padding(.trailing, 10)
                            }, alignment: .trailing
                            
                        )
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 3.0)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
        .padding(.bottom, 5)
    }
}


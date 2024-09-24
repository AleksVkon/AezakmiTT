//
//  ContentView.swift
//  AezakmiTestTask
//
//  Created by Aleksey Konchyts on 24.09.24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = "Admin@admin.com"
    @State private var password = "admin"
    @State private var errorMessage = ""
    @State private var showResetPasswordView = false
    @State private var isAuthenticated = false
    
    let validationHelper = ValidationHelper()
    
    var body: some View {
        NavigationStack{
            VStack {
                TextField("Enter email (Admin@admin.com)", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal, 40)
                
                SecureField("Enter Password (admin)", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)
                
                Button(action: {
                    if validationHelper.signInWithEmail(email:email, password: password, errorMessage: &errorMessage){
                        isAuthenticated = true
                    }
                }, label: {
                    Text("Enter")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                })
                .padding(.horizontal)
                
                Button(action: {
                    showResetPasswordView.toggle()
                }, label: {
                    Text("Напомнить пароль?")
                        .foregroundStyle(.blue)
                })
                
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .padding()
                
                NavigationLink(destination: PhotoEditorView(), isActive: $isAuthenticated){
                    EmptyView()
                }
            }
            .padding()
            
            .sheet(isPresented: $showResetPasswordView) {
                ResetPasswordView(isPresented: $showResetPasswordView)
            }
        }
    }
}

#Preview {
    LoginView()
}

//
//  SwiftUIView.swift
//  AezakmiTestTask
//
//  Created by Aleksey Konchyts on 25.09.24.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var email = ""
    @State private var errorMessage = ""
    @Binding var isPresented: Bool
    
    let validationHelper = ValidationHelper()
    
    var body: some View {
        VStack(spacing: 20){
            Text("Напомнить Ваш пароль?")
                .font(.headline)
            
            TextField("Введите Ваш email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.none)
                .autocorrectionDisabled(true)
                .keyboardType(.emailAddress)
                .padding(.horizontal, 40)
            
            Text(errorMessage)
                .foregroundStyle(.red)
                .font(.headline)
                .padding()
            
            Button(action: {
                if validationHelper.isValidEmail(email) {
                    //Тут должна быть логика отправки пароля, в тестовом задании просто вывожу пароль текстом с задержкой на 2 секунды
                    errorMessage = "Ваш пароль - Admin"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isPresented = false
                    }
                } else {
                    errorMessage = "неправильный email"
                }
            }, label: {
                Text("Отправить пароль")
                    .foregroundStyle(.tint)
                    .padding()
            })
            
            Button(action: {
                isPresented = false
            }, label: {
                Text("Отмена")
                    .foregroundStyle(.red)
            })
            .padding()
        }
    }
}



#Preview {
    ResetPasswordView (isPresented: .constant(true))
}

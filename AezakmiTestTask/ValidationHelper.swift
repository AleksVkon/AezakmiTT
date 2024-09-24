//
//  ValidationHelper.swift
//  AezakmiTestTask
//
//  Created by Aleksey Konchyts on 25.09.24.
//

import Foundation

struct ValidationHelper {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validateInputs(email:String, password: String, errorMessage: inout String) -> Bool {
        if email.isEmpty || !isValidEmail(email) {
            errorMessage = "Не правильный Email"
            return false
        }
        if password.isEmpty || password.count < 4 {
            errorMessage = "Пароль должен содержать не менее 6 символов"
            return false
        }
        return true
    }
    
    func signInWithEmail (email:String, password: String, errorMessage: inout String) -> Bool {
        if validateInputs (email:email, password: password, errorMessage: &errorMessage) {
            // тут должна быть отправка данных на сервер для проверки данных, но сделал просто сравнение с admin@admin.com/admin
            if email == "Admin@admin.com" && password == "admin" {
                errorMessage = "Ура! Мы вошли!"
                return true
            } else {
                errorMessage = "Не правильной email или password"
                return false
            }
        }
        return false
    }
}

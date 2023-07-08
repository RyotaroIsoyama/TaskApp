//
//  LoginViewViewModel.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/08.
//
import FirebaseAuth
import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password)
    }
}

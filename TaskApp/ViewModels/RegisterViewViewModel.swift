//
//  RegisterViewViewModel.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/07.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            let newUser = User(id: userId,
                               name: self.name,
                               email: self.email,
                               joined: Date().timeIntervalSince1970)
            
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(userId)
                .setData(newUser.asDictionary())
        }
    }
}

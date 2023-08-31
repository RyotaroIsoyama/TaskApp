//
//  AuthViewModel.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/20.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class AuthViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var didAuthenticateUser = false
    @Published var userSession: FirebaseAuth.User?
    private var tempUserSession: FirebaseAuth.User?

    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let user = result?.user else {
                return
            }
            
            let userId = user.uid
            
            self.tempUserSession = user
            //self.userSession = user
            
            let newUser = User(id: userId,
                               name: self.name,
                               email: self.email,
                               profileImageURL: "",
                               joined: Date().timeIntervalSince1970)
            
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(userId)
                .setData(newUser.asDictionary()) { _ in
                    self.didAuthenticateUser = true
                }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let user = result?.user else {
                return
            }
            
            self.userSession = user
        }
    }
    
    func logout() {
        do {
            userSession = nil
            try Auth.auth().signOut()
        } catch {
            print("Logout Error")
        }
        
        self.email = ""
        self.name = ""
        self.password = ""
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageURL in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageURL": profileImageURL]) { _ in
                    self.userSession = self.tempUserSession
                }
        }
    }
}

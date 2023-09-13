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
    @Published var userSession: User?
    var tempUserSession: User?

    var authRepository: AuthRepository
    var userRepository: UserRepository
    
    init(authRepository: AuthRepository = AuthRepositoryImpl(), userRepository: UserRepository = UserRepositoryImpl()) {
        self.authRepository = authRepository
        self.userRepository = userRepository
        
        if let currentUser = Auth.auth().currentUser {
            self.userSession = convertToCustomUser(currentUser)
        } else {
            self.userSession = nil
        }
    }
    
    func convertToCustomUser(_ firebaseUser: FirebaseAuth.User) -> User {
        return User(id: firebaseUser.uid,
                    name: "", // Firebaseから名前を取得する方法があればここに設定
                    email: firebaseUser.email ?? "",
                    profileImageURL: "", // プロフィール画像URLを設定する方法があればここに設定
                    joined: 0) // 加入日時を設定する方法があればここに設定
    }

    func register() {
        authRepository.createUser(withEmail: email, password: password) { result in
            switch result {
            case .success(let user):
                
                let userId = user?.id
                
                self.tempUserSession = user
                
                let newUser = User(id: userId ?? "",
                                   name: self.name,
                                   email: self.email,
                                   profileImageURL: "",
                                   joined: Date().timeIntervalSince1970)
                
                self.userRepository.saveUser(newUser) { result in
                    switch result {
                    case .success(let success):
                        if success {
                            self.didAuthenticateUser = true
                        } else {
                            print("Failed to save user data to Firestore")
                        }
                    case .failure(let error):
                        print("User registration failed: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("User registration failed: \(error.localizedDescription)")
            }
        }
    }

    func login() {
        authRepository.signIn(withEmail: email, password: password) { result in
            switch result {
            case .success(let user):
                self.userSession = user
            case .failure(let error):
                // ユーザー作成失敗時のエラーハンドリング
                self.userSession = nil
                print("User registration failed: \(error.localizedDescription)")
            }
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
        guard let uid = tempUserSession?.id else { return }

        ImageUploader.uploadImage(image) { profileImageURL in
            switch profileImageURL {
            case .success(let profileImageURL):
                self.userRepository.uploadUserImage(uid, profileImageURL) { result in
                    switch result {
                    case .success(let success):
                        if success {
                            self.userSession = self.tempUserSession
                        } else {
                            print("Failed to save user data to Firestore")
                        }
                    case .failure(let error):
                        print("User registration failed: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("Creating profileImageURL failed: \(error.localizedDescription)")
            }
        }
    }
}

//
//  UserRepositoryImpl.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/09/14.
//

import Foundation
import Firebase

class AuthRepositoryImpl: AuthRepository {
    func createUser(withEmail email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                let user = self.convertToCustomUser(user)
                completion(.success(user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    func signIn(withEmail email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                let user = self.convertToCustomUser(user)
                completion(.success(user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    func convertToCustomUser(_ firebaseUser: FirebaseAuth.User) -> User {
        return User(id: firebaseUser.uid,
                    name: "", // Firebaseから名前を取得する方法があればここに設定
                    email: firebaseUser.email ?? "",
                    profileImageURL: "", // プロフィール画像URLを設定する方法があればここに設定
                    joined: 0) // 加入日時を設定する方法があればここに設定
    }
}

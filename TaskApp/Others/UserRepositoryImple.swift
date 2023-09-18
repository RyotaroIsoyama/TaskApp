//
//  UserRepositoryImple.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/09/14.
//

import Foundation
import Firebase

class UserRepositoryImpl: UserRepository {
    func saveUser(_ user: User, completion: @escaping (Result<Bool, Error>) -> Void ) {
        let firestore = Firestore.firestore()
        let userData: [String: Any] = [
            "id": user.id,
            "name": user.name,
            "email": user.email,
            "profileImageURL": user.profileImageURL,
            "joined": user.joined
        ]
        // firestoreの操作を行う
        let collection = firestore.collection("users")
        let document = collection.document(user.id)
        
        document.setData(userData) { error in
            if let error = error {
                print("Firestore setData failed: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("User data saved successfully")
                completion(.success(true))
            }
        }
    }
    
    func uploadUserImage(_: String, _: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        func uploadUserImage(_ uid: String, _ profileImageURL: String, completion: @escaping (Result<Bool, Error>) -> Void) {
            let firestore = Firestore.firestore()
            
            let userId = uid
            let collection = firestore.collection("users")
            let document = collection.document(userId)
            
            document.updateData(["profileImageURL": profileImageURL]) { error in
                if let error = error {
                    print("Firestore updataData failed: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("ProfileImage is saved successfully")
                    completion(.success(true))
                }
            }
        }
    }
}

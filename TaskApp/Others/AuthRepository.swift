//
//  AuthRepository.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/09/12.
//

import Foundation

protocol AuthRepository {
    func createUser(withEmail email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void)
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void)
}

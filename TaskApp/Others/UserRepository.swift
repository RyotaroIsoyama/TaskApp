//
//  UserRepository.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/09/09.
//

import Foundation

protocol UserRepository {
    func saveUser(_: User, completion: @escaping (Result<Bool, Error>) -> Void)

    func uploadUserImage(_: String, _: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

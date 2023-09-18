//
//  TaskRepository.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/09/14.
//

import Foundation

protocol TaskRepository {
    func save(_: Task, _: String, completion: @escaping (Result<Bool, Error>) -> Void)
    
    func update(_: Task, _: String, completion: @escaping (Result<Bool, Error>) -> Void)
    
    func toggle(_: Task, _: String, completion: @escaping (Result<Bool, Error>) -> Void)
    
    func delete(_: String, _: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

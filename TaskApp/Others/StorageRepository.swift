//
//  StorageRepository.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/09/12.
//

import Foundation

protocol StorageRepository {
    func uploadData(data: Data, to path: String, completion: @escaping (Result<String, Error>) -> Void)
}

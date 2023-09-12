//
//  StorageRepositoryImpl.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/09/12.
//

import Foundation
import FirebaseStorage

class StorageRepositoryImpl: StorageRepository {
    func uploadData(data: Data, to path: String, completion: @escaping (Result<String, Error>) -> Void) {
        let ref = Storage.storage().reference(withPath: path)
 
        ref.putData(data, metadata: nil) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                ref.downloadURL { imageURL, _ in
                    if let imageURL = imageURL?.absoluteString {
                        completion(.success(imageURL))
                    } else {
                        completion(.failure(NSError(domain: "DownloadURLError", code: 0, userInfo: nil)))
                    }
                }
            }
        }
    }
}

//
//  ImageUploader.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/20.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

struct ImageUploader {
    static var storageRepository: StorageRepository?
    
    static func initialize(storageRepository: StorageRepository) {
        self.storageRepository = storageRepository
    }

//    init(storageService: StorageService) {
//        self.storageService = storageService
//    }
    
    static func uploadImage(_ image: UIImage, completion: @escaping ((Result<String, Error>)) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        let filename = NSUUID().uuidString
        let path = "/profile_image/\(filename)"
//        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        guard let storageRepository = self.storageRepository else {
            completion(.failure(NSError(domain: "ImageUploader", code: 1, userInfo: [NSLocalizedDescriptionKey: "StorageService is not initialized"])))
            return
        }
        
        storageRepository.uploadData(data: imageData, to: path) { result in
            switch result {
            case .success(let imageURL):
                completion(.success(imageURL))
            case .failure(let error):
                completion(.failure(error))
            }
        }
//        ref.putData(imageData, metadata: nil) { _ , error in
//            if error != nil {
//                return
//            }
//
//            ref .downloadURL { imageURL, _ in
//                guard let imageURL = imageURL?.absoluteString else {
//                    return
//                }
//                completion(imageURL)
//            }
//        }
    }
}

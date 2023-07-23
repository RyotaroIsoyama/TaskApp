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
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        
        ref.putData(imageData, metadata: nil) { _ , error in
            if error != nil {
                return
            }
            
            ref .downloadURL { imageURL, _ in
                guard let imageURL = imageURL?.absoluteString else {
                    return
                }
                completion(imageURL)
            }
        }
    }
}

//
//  TaskRepositoryImpl.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/09/14.
//

import Foundation
import Firebase

class TaskRepositoryImpl: TaskRepository {
    func save(_ task: Task, _ taskId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let firestore = Firestore.firestore()
        let collection = firestore.collection("users").document(uId).collection("tasks")
        let document = collection.document(taskId)
        
        let taskData: [String : Any] = [
            "id": task.id,
            "title": task.title,
            "category": task.category.rawValue,
            "dueDate": task.dueDate,
            "createDate": task.createDate,
            "isDone": task.isDone
        ]
        
        document.setData(taskData) { error in
            if let error = error {
                print("Firestore setData failed: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Task data saved successfully")
                completion(.success(true))
            }
        }
    }
    
    func update(_ task: Task, _ taskId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let firestore = Firestore.firestore()
        let colletcion = firestore.collection("users").document(uId).collection("tasks")
        let document = colletcion.document(taskId)
        
        let updatedTask: [String : Any] = [
            "id": task.id,
            "title": task.title,
            "category": task.category.rawValue,
            "dueDate": task.dueDate,
            "createDate": task.createDate,
            "isDone": task.isDone
        ]
        
        document.updateData(updatedTask) { error in
            if let error = error {
                print("Firestore updateData failed: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Task update successfully")
                completion(.success(true))
            }
        }
    }
    
    func toggle(_ task: Task, _ taskId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let firestore = Firestore.firestore()
        let collection = firestore.collection("users").document(uId).collection("tasks")
        let document = collection.document(taskId)
        
        let taskData: [String : Any] = [
            "id": task.id,
            "title": task.title,
            "category": task.category.rawValue,
            "dueDate": task.dueDate,
            "createDate": task.createDate,
            "isDone": task.isDone
        ]
        
        document.setData(taskData) { error in
            if let error = error {
                print("Firestore setData failed: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Task data saved successfully")
                completion(.success(true))
            }
        }
    }
    
    func delete(_ taskId: String, _ userId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let firestore = Firestore.firestore()
        let collection = firestore.collection("users").document(userId).collection("tasks")
        let document = collection.document(taskId)
        
        document.delete() { error in
            if let error = error {
                print("Firestore delete task failed: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Task is deleted successfully")
                completion(.success(true))
            }
        }
    }
}

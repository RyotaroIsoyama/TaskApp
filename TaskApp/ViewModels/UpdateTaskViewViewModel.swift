//
//  UpdateTaskViewViewModel.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/11.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class UpdateTaskViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var category: Category = .work
    @Published var dueDate = Date()
    
    func update(id: String) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let taskId = id
        let updatedTask = Task(id: taskId,
                               title: title,
                               category: Category(rawValue: category.rawValue) ?? .work,
                               dueDate: dueDate.timeIntervalSince1970,
                               createDate: Date().timeIntervalSince1970,
                               isDone: false
        )
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("tasks")
            .document(taskId)
            .setData(updatedTask.asDictionary())
    }
}

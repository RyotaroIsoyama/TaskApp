//
//  NewTaskViewViewModel.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/09.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewTaskViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    
    func save() {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let taskId = UUID().uuidString
        let newTask = Task(id: taskId,
                           title: title,
                           dueDate: dueDate.timeIntervalSince1970,
                           createDate: Date().timeIntervalSince1970,
                           isDone: false
        )
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("tasks")
            .document(taskId)
            .setData(newTask.asDictionary())
    }
}

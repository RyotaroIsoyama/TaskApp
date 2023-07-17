//
//  TaskItemViewViewModel.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/15.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class TaskItemViewViewModel: ObservableObject {
    func toggle(task: Task) {
        var toggledtask = task
        
        toggledtask.isDone.toggle()
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("tasks")
            .document(toggledtask.id)
            .setData(toggledtask.asDictionary())
    }
}

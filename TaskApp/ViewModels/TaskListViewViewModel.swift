//
//  NewTaskViewViewModel.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/08.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

class TaskListViewViewModel: ObservableObject {
    @Published var showingNewTaskView: Bool = false
    
    private var userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("tasks")
            .document(id)
            .delete()
        
    }
}

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
    private var userId: String?
    
    var taskRepository: TaskRepository
    
    init(userId: String, taskRepository: TaskRepository = TaskRepositoryImpl()) {
        self.userId = userId
        self.taskRepository = taskRepository
    }
    
//    init(userId: String) {
//        self.userId = userId
//    }
    
    func delete(id: String) {
        if let userId = self.userId {
            self.taskRepository.delete(id, userId) { result in
                switch result {
                case .success(let success):
                    if success {
                        // 削除が成功した場合の処理
                        print("Task deleted successfully")
                    } else {
                        // 削除が失敗した場合の処理
                        print("Failed to delete task")
                    }
                case .failure(let error):
                    // エラーが発生した場合の処理
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
//        let db = Firestore.firestore()
//
//        db.collection("users")
//            .document(userId)
//            .collection("tasks")
//            .document(id)
//            .delete()
        
    }
}

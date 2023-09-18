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
    var taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository = TaskRepositoryImpl()) {
        self.taskRepository = taskRepository
    }
    
    func toggle(task: Task) {
        var toggledtask = task
        let taskId = task.id
        
        toggledtask.isDone.toggle()
        
        self.taskRepository.toggle(toggledtask, taskId) { result in
            switch result {
            case .success(let success):
                if success {
                    // 保存が成功した場合の処理
                    print("Task saved successfully")
                } else {
                    // 保存が失敗した場合の処理
                    print("Failed to save task")
                }
            case .failure(let error):
                // エラーが発生した場合の処理
                print("Error: \(error.localizedDescription)")
            }
        }
        
//        guard let uid = Auth.auth().currentUser?.uid else {
//            return
//        }
//
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(uid)
//            .collection("tasks")
//            .document(toggledtask.id)
//            .setData(toggledtask.asDictionary())
    }
}

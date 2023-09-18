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
    
    var taskRepository: TaskRepository
    
    init(taskRepository: TaskRepository = TaskRepositoryImpl()) {
        self.taskRepository = taskRepository
    }
    
    func update(id: String) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
//        guard let uId = Auth.auth().currentUser?.uid else {
//            return
//        }
        
        let taskId = id
        let updatedTask = Task(id: taskId,
                               title: title,
                               category: Category(rawValue: category.rawValue) ?? .work,
                               dueDate: dueDate.timeIntervalSince1970,
                               createDate: Date().timeIntervalSince1970,
                               isDone: false
        )
        
        self.taskRepository.update(updatedTask, taskId) { result in
            switch result {
            case .success(let success):
                if success {
                    // 保存が成功した場合の処理
                    print("Task updated successfully")
                } else {
                    // 保存が失敗した場合の処理
                    print("Failed to update task")
                }
            case .failure(let error):
                // エラーが発生した場合の処理
                print("Error: \(error.localizedDescription)")
            }
        }
        
//        let db = Firestore.firestore()
//        
//        db.collection("users")
//            .document(uId)
//            .collection("tasks")
//            .document(taskId)
//            .setData(updatedTask.asDictionary())
    }
}

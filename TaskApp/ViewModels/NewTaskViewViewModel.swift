//
//  NewTaskViewViewModel.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/09.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

protocol UserProtocol {
    var uid: String? { get  }
}

protocol FirebaseAuthProtocol {
    var currentUser: UserProtocol? { get }
}

class FirebaseAuthWrapper: FirebaseAuthProtocol {
    static let shared = FirebaseAuthWrapper()

    var currentUser: UserProtocol? {
        if let authUser = Auth.auth().currentUser as? UserProtocol {
            return authUser
        } else {
            return nil
        }
    }
}


class NewTaskViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var category: Category = .work
    @Published var dueDate = Date()

    var auth: FirebaseAuthProtocol

    var firestore: FirestoreProtocol

    init(auth: FirebaseAuthProtocol = FirebaseAuthWrapper.shared, firestore: FirestoreProtocol = FirebaseFirestoreService()) {
        self.auth = auth
        self.firestore = firestore
    }

    func save() {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }

        guard let uId = auth.currentUser?.uid else {
            return
        }

        let taskId = UUID().uuidString
        let newTask = Task(id: taskId,
                           title: title,
                           category: Category(rawValue: category.rawValue) ?? .work,
                           dueDate: dueDate.timeIntervalSince1970,
                           createDate: Date().timeIntervalSince1970,
                           isDone: false
        )

        self.firestore.collection("users")
            .document(uId)
            .collection("tasks")
            .document(taskId)
            .setData(newTask.asDictionary()) { _ in

            }
    }
}

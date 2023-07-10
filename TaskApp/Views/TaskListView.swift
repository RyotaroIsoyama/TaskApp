//
//  TaskListView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/08.
//
import FirebaseFirestoreSwift
import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel = TaskListViewViewModel()
    @FirestoreQuery var tasks: [Task]
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
        
        self._tasks = FirestoreQuery(collectionPath: "users/\(userId)/tasks")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(tasks) { task in
                    TaskItemView(task: task)
                }
            }
            .navigationTitle("Task List")
            .toolbar {
                Button {
                    viewModel.showingNewTaskView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewTaskView) {
                NewTaskView(newTaskPresented: $viewModel.showingNewTaskView)
            }

        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(userId: "")
    }
}

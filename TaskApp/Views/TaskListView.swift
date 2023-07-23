//
//  TaskListView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/08.
//
import FirebaseFirestoreSwift
import FirebaseAuth
import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel: TaskListViewViewModel
    @FirestoreQuery var tasks: [Task]
    @State private var isDoneOnly = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
        
        self._tasks = FirestoreQuery(collectionPath: "users/\(userId)/tasks")
        
        //_viewModel プロパティラッパーStateObjectの補助プロパティ
        //wrappedValue StateObjectに初期値を与える
        self._viewModel = StateObject(wrappedValue: TaskListViewViewModel(userId: userId))
    }
    
    var filteredTasks: [Task] {
        tasks.filter { task in
            (!isDoneOnly || !task.isDone)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Toggle(isOn: $isDoneOnly) {
                        Text("Not Done Tasks only")
                    }
                    
                    ForEach(filteredTasks) { task in
                        NavigationLink(destination: TaskDetailView(task: task)) {
                            TaskItemView(task: task)
                        }
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(id: task.id)
                            }
                            .tint(.red)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .top, endPoint: .bottom))
            }
            .navigationBarItems(leading: Text("Task List")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 50)
                .padding(.bottom, 30))
            .toolbar {
                Button {
                    viewModel.showingNewTaskView = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
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

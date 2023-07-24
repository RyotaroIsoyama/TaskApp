//
//  TaskDetailView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/10.
//

import SwiftUI

struct TaskDetailView: View {
    @StateObject var viewModel = TaskDetailViewViewModel()
    
    var task: Task
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text(task.title )
                        .font(.system(size: 22, weight: .regular))
                        .padding()
                    
                    Text(task.category.rawValue)
                    
                    Text("\(Date(timeIntervalSince1970: task.dueDate).formatted(date: .abbreviated, time: .shortened))")
                        .font(.system(size: 22, weight: .regular))
                        .padding()
                    
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.showingUpdateTaskView = true
                    } label: {
                        Text("Edit")
                            .bold()
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingUpdateTaskView) {
                UpdateTaskView(updatedTaskPresented: $viewModel.showingUpdateTaskView, task: task)
            }
        }.navigationTitle("Details")
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: .init(id: "1",
                                   title: "title",
                                   category: .work,
                                   dueDate: Date().timeIntervalSince1970,
                                   createDate: Date().timeIntervalSince1970, isDone: false
                                  )
        )
    }
}

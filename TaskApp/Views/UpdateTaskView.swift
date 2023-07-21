//
//  UpdateTaskView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/11.
//

import SwiftUI

struct UpdateTaskView: View {
    @StateObject var viewModel = UpdateTaskViewViewModel()
    @Binding var updatedTaskPresented: Bool
    var task: Task
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Update Task")
                    .font(.system(size: 32))
                    .bold()
                    .padding(.top, 50)
                
                Form {
                    TextField("\(task.title)", text: $viewModel.title)
                        .onAppear(){
                            viewModel.title = task.title
                        }
                    
                    Picker(selection: $viewModel.category, label: Text("カテゴリーを選択")) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .onAppear {
                        viewModel.category = task.category
                    }
                    
                    DatePicker("Due Date", selection: $viewModel.dueDate)
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                    Button {
                        viewModel.update(id: task.id)
                        updatedTaskPresented = false
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.blue)
                            Text("Update")
                                .foregroundColor(Color.white)
                                .bold()
                        }
                    }
                    .padding()
                    
                }
            }
        }
    }
}

struct UpdateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTaskView(updatedTaskPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }), task: .init(id: "1",
                        title: "title",
                        category: .work,
                        dueDate: Date().timeIntervalSince1970,
                        createDate: Date().timeIntervalSince1970, isDone: false
                       ))
    }
}

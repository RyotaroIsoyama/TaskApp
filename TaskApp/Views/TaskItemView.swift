//
//  TaskItemView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/10.
//

import SwiftUI

struct TaskItemView: View {
    @StateObject var viewModel = TaskItemViewViewModel()
    let task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .bold()
                
                Text("\(Date(timeIntervalSince1970: task.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
            }
            
            Spacer()
            
            Button {
                viewModel.toggle(task: task)
            } label: {
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.blue)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct TaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemView(task: .init(id: "1",
                                 title: "title",
                                 category: .work,
                                 dueDate: Date().timeIntervalSince1970,
                                 createDate: Date().timeIntervalSince1970,
                                 isDone: false))
    }
}

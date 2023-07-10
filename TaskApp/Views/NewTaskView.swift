//
//  NewTaskView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/08.
//

import SwiftUI

struct NewTaskView: View {
    @StateObject var viewModel = NewTaskViewViewModel()
    @Binding var newTaskPresented: Bool
    
    var body: some View {
        VStack {
            Text("New Task")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            
            Form {
                TextField("title", text: $viewModel.title)
                
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                Button {
                    viewModel.save()
                    newTaskPresented = false
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.blue)
                        Text("Save")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                }
                .padding()
                
            }
            
            
        }
        
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(newTaskPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
        
    }
}

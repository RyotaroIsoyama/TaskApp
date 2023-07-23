//
//  CategoryRowView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/17.
//
import FirebaseFirestoreSwift
import FirebaseAuth
import SwiftUI

struct CategoryRowView: View {
    @FirestoreQuery var tasks: [Task]
    let categoryName: String

    init(categoryName: String) {
        let userId = Auth.auth().currentUser!.uid
        self._tasks = FirestoreQuery(collectionPath: "users/\(userId)/tasks")
        self.categoryName = categoryName
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(tasks.filter { $0.category.rawValue == categoryName }) { task in
                        NavigationLink(destination: TaskDetailView(task: task)) {
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .foregroundColor(Color.black)
                                    .bold()
                                    .frame(width: 100, height: 100)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 4)
                                    }
                                    .shadow(radius: 7)
                            }
                            .padding(5)
                        }
                    }
                }
            }
        }
    }
}

//struct CategoryRowView_Previews: PreviewProvider {
    //static var previews: some View {
        //CategoryRowView(tasks: <#T##[Task]#>, categoryNumber: 0)
    //}
//}

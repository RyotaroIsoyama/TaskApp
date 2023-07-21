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
        //self.categoryNumber = categoryNumber
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
                        VStack(alignment: .leading) {
                            Image(systemName: "car.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(5)
                            Text(task.title)
                                .font(.caption)
                        }
                        .padding(.leading, 15)
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

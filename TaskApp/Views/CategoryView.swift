//
//  CategoryView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/17.
//
import FirebaseFirestoreSwift
import FirebaseAuth
import SwiftUI

struct CategoryView: View {
    
    var body: some View {
        NavigationView {            
            List {
                ForEach(Category.allCases, id: \.self) { category in
                    CategoryRowView(categoryName: category.rawValue)
                    Divider()
                }
                .navigationBarItems(leading: Text("Task List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                    .padding(.bottom, 30))
            }
            .scrollContentBackground(.hidden)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .top, endPoint: .bottom))
        }
        
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}

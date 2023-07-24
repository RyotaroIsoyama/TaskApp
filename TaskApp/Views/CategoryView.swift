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
    let categories = ["仕事", "家事", "プライベート", "その他"]
    
    var body: some View {
        NavigationView {            
            List {
                ForEach(Category.allCases, id: \.self) { category in
                    CategoryRowView(categoryName: category.rawValue)
                }
                .navigationTitle("Category")
            }
        }
        
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}

//
//  ContentView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/07.
//

import FirebaseAuth
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        //if viewModel.isLoggedIn {
        if authViewModel.userSession != nil {
            TabView {
                TaskListView(userId: Auth.auth().currentUser!.uid)
                    .tabItem {
                        Label("Tasks", systemImage: "list.clipboard")
                    }
                CategoryView()
                    .tabItem {
                        Label("Category", systemImage: "star")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            }
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


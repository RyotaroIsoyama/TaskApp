//
//  ProfileView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/07.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 125, height: 125)
                    .padding()
                
                if let user = viewModel.user {
                    HStack {
                        Text("Name")
                            .bold()
                        Text(user.name)
                    }
                    .padding()
                    
                    HStack {
                        Text("")
                            .bold()
                        Text(user.email)
                    }
                    .padding()
                } else {
                    Text("Loading Profile...")
                }
                
                Button {
                    viewModel.logout()
                } label: {
                    Text("Logout")
                }

            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

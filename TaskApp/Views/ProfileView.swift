//
//  ProfileView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/07.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image("profile-background-image")
                    .resizable()
                    .frame(height: 300)
                
                KFImage(URL(string: viewModel.user?.profileImageURL ?? ""))
                    .resizable()
                    .frame(width: 125, height: 125)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .offset(y: -75)
                    .padding(.bottom, -90)
                
                if let user = viewModel.user {
                    Text(user.name)
                        .bold()
                        .padding()
                    
                        Text(user.email)
                        .bold()
                        .padding()
                } else {
                    Text("Loading Profile...")
                }
                                
                Button {
                    authViewModel.logout()
                } label: {
                    Text("Logout")
                }
                
                Spacer()

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

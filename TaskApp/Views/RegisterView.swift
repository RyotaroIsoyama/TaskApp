//
//  RegisterView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/07.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            NavigationLink(destination: ProfilePhotoSelectView(),
                           isActive: $authViewModel.didAuthenticateUser,
                           label: { })
            
            HeaderView(title: "Welcome to TaskApp",
                       subtitle: "Let's create your account",
                       headerColor: Color.green)
            
            Form {
                TextField("Name", text: $authViewModel.name)
                
                TextField("Email", text: $authViewModel.email)
                
                SecureField("Password", text: $authViewModel.password)
                
                
                Button {
                    authViewModel.register()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.blue)
                        Text("Register")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                }
                .padding()

            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

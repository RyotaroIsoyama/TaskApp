//
//  LoginView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/07.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "Please Login",
                           subtitle: "Enter your account information",
                           headerColor: Color.blue)
                
                Form {
                    
                    TextField("Email", text: $authViewModel.email)
                    
                    SecureField("Password", text: $authViewModel.password)
                    
                    
                    Button {
                        //viewModel.login()
                        authViewModel.login()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.blue)
                            Text("Login")
                                .foregroundColor(Color.white)
                                .bold()
                        }
                    }
                    .padding()

                }
                
                VStack {
                    Text("You don't have account?")
                    NavigationLink("Click here", destination: RegisterView())
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

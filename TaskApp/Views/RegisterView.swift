//
//  RegisterView.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/07.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        VStack {
            HeaderView(title: "Welcome to TaskApp",
                       subtitle: "Let's create your account",
                       headerColor: Color.green)
            
            Form {
                TextField("Name", text: $viewModel.name)
                
                TextField("Email", text: $viewModel.email)
                
                SecureField("Password", text: $viewModel.password)
                
                
                Button {
                    viewModel.register()
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

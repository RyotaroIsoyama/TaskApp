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
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color.green)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Welecome TaskApp")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    Text("Let's create your account")
                        .font(.system(size: 20))
                        .foregroundColor(.white)

                }
            }
            
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

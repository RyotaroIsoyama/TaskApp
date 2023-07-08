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
    
    var body: some View {
        if viewModel.isLoggedIn {
            ProfileView()
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


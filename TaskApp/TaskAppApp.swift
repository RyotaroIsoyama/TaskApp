//
//  TaskAppApp.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/07.
//
import FirebaseCore
import SwiftUI

@main
struct TaskAppApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
        
        let storageRepository = StorageRepositoryImpl()
        ImageUploader.initialize(storageRepository: storageRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

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
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

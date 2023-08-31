////
////  ContentViewViewModel.swift
////  TaskApp
////
////  Created by 久保田陽介 on 2023/07/08.
////
//
//import FirebaseAuth
//import Foundation
//
//class ContentViewViewModel: ObservableObject {
//    @Published var isLoggedIn = false
//
//    private var handler: AuthStateDidChangeListenerHandle?
//
//    init() {
//        self.handler = Auth.auth().addStateDidChangeListener{ _, user in
//            if user != nil {
//                self.isLoggedIn = true
//            } else {
//                self.isLoggedIn = false
//            }
//        }
//    }
//}

////
////  TaskCRUDTests.swift
////  TaskAppTests
////
////  Created by 久保田陽介 on 2023/09/07.
////
//
//import XCTest
//@testable import TaskApp
//
//class MockFirebaseAuth: FirebaseAuthProtocol {
//    var currentUser: UserProtocol?
//}
//
//
//final class TaskCRUDTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        
//    }
//
//    override func tearDownWithError() throws {
//        
//    }
//    
//    class MockFirestore: FirestoreProtocol {
//        var setDataCalled = false
//        
//        func collection(_ collectionPath: String) -> CollectionReferenceProtocol {
//            return MockCollectionReference()
//        }
//    }
//    
//    class MockCollectionReference: CollectionReferenceProtocol {
//        var setDataCalled = false
//        
//        func document(_ documentPath: String) -> DocumentReferenceProtocol {
//            return MockDocumentReference()
//        }
//    }
//
//    class MockDocumentReference: DocumentReferenceProtocol {
//        var setDataCalled = false
//        
//        func collection(_ collectionPath: String) -> TaskApp.CollectionReferenceProtocol{
//            fatalError("")
//        }
//        
//        func setData(_ documentData: [String: Any], completion: ((Error?) -> Void)?) {
//            setDataCalled = true
//        }
//    }
//
//    func testTaskSave() {        
//        let mockAuth = MockFirebaseAuth()
//        let mockFirestore = MockFirestore()
//        let viewModel = NewTaskViewViewModel(auth: mockAuth, firestore: mockFirestore)
//        
//        let mockUserId = "testUserId"
//        mockAuth.currentUser = MockUser(uid: mockUserId) as? any UserProtocol
//        
//        viewModel.title = "title"
//        viewModel.category = .work
//        viewModel.dueDate = Date()
//        
//        viewModel.save()
//        
//        XCTAssertTrue(mockFirestore.setDataCalled)
//    }
//    
//    func testExample() throws {
//    }
//
//    func testPerformanceExample() throws {
//        self.measure {
//            
//        }
//    }
//
//}
//スキームの設定変更

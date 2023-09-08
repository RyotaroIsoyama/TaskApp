//
//  TaskAppTests.swift
//  TaskAppTests
//
//  Created by 久保田陽介 on 2023/09/02.
//


import XCTest
@testable import TaskApp
import Firebase
import FirebaseAuth

final class TaskAppTests: XCTestCase {
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }
    
    class MockAuthService: AuthServiceProtocol {
        func createUser(withEmail email: String, password: String, completion: @escaping (Result<TaskApp.User?, Error>) -> Void) {
            let user = User(id: "testUserID", name: "Yosuke", email: email, profileImageURL: "", joined: 0)
            completion(.success(user))
        }
        
        func signIn(withEmail email: String, password: String, completion: @escaping (Result<TaskApp.User?, Error>) -> Void) {
            if email == "kubotayosuke@gmail.com" && password == "1111" {
                let user = User(id: "testUserID", name: "Yosuke", email: email, profileImageURL: "", joined: 0)
                completion(.success(user))
            } else {
                print(email)
                let error = NSError(domain: "InvalidCredentials", code: 1, userInfo: nil)
                completion(.failure(error))
            }
        }
    }
    
    class MockFirestore: FirestoreProtocol {
        func collection(_ collectionPath: String) -> CollectionReferenceProtocol {
            return MockCollectionReference()
        }
    }

    class MockCollectionReference: CollectionReferenceProtocol {
        func document(_ documentPath: String) -> DocumentReferenceProtocol {
            return MockDocumentReference()
        }
    }

    class MockDocumentReference: DocumentReferenceProtocol {
        func collection(_ collectionPath: String) -> TaskApp.CollectionReferenceProtocol {
            fatalError("")
        }
        
        func setData(_ documentData: [String: Any], completion: ((Error?) -> Void)?) {
            completion?(nil)
        }
    }
    
    
    func testRegister() {
        let mockAuthService = MockAuthService()
        let mockFirestore = MockFirestore()
        let viewModel = AuthViewModel(authService: mockAuthService, firestore: mockFirestore)
        
        viewModel.name = "Yosuke"
        viewModel.email = "kubotayosuke@gmail.com"
        viewModel.password = "1111"
        
        viewModel.register()
            
        XCTAssertTrue(viewModel.didAuthenticateUser)
    }
    
    func testLoginSuccess() {
        let mockAuthService = MockAuthService()
        let viewModel = AuthViewModel(authService: mockAuthService)

        viewModel.email = "kubotayosuke@gmail.com"
        viewModel.password = "1111"

        viewModel.login()

        XCTAssertNotNil(viewModel.userSession)
        XCTAssertEqual(viewModel.userSession?.email, "kubotayosuke@gmail.com")
    }
    
    func testLoginFail() {
        let mockAuthService = MockAuthService()
        let viewModel = AuthViewModel(authService: mockAuthService)

        viewModel.email = "invalid_email@gmail.com"
        viewModel.password = "invalid_password"
                
        viewModel.login()
        
        XCTAssertNil(viewModel.userSession)
    }
    
    func testLogout() {
        let mockAuthService = MockAuthService()
        let viewModel = AuthViewModel(authService: mockAuthService)

        viewModel.email = "kubotayosuke@gmail.com"
        viewModel.password = "1111"

        viewModel.login()

        XCTAssertNotNil(viewModel.userSession)
        XCTAssertEqual(viewModel.userSession?.email, "kubotayosuke@gmail.com")
        
        viewModel.logout()
        XCTAssertNil(viewModel.userSession)
    }

    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        measure {
            
        }
    }
}


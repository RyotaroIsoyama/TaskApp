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

final class UserTests: XCTestCase {
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }
    
    class MockAuthRepositoryImpl: AuthRepository {
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
    
    class MockUserRepositoryImpl: UserRepository {
        var saveUserResult: Result<Bool, Error>?
        var uploadUserImageResult: Result<Bool, Error>?
        
        func saveUser(_: TaskApp.User, completion: @escaping (Result<Bool, Error>) -> Void) {
            if let result = saveUserResult {
                completion(result)
            }
        }
        
        func uploadUserImage(_: String, _: String, completion: @escaping (Result<Bool, Error>) -> Void) {
            if let result = uploadUserImageResult {
                completion(result)
            }
        }
    }
    
    class MockStorageRepository: StorageRepository {
        var uploadDataResult: Result<String, Error>?
        
        func uploadData(data: Data, to path: String, completion: @escaping (Result<String, Error>) -> Void) {
            if let result = uploadDataResult {
                completion(result)
            }
        }
    }
    
    
    func testRegister() {
        let mockAuthRepository = MockAuthRepositoryImpl()
        let mockUserRepository = MockUserRepositoryImpl()
        mockUserRepository.saveUserResult = .success(true)
        
        let viewModel = AuthViewModel(authRepository: mockAuthRepository, userRepository: mockUserRepository)
        
        viewModel.name = "Yosuke"
        viewModel.email = "kubotayosuke@gmail.com"
        viewModel.password = "1111"
        
        viewModel.register()
        
        XCTAssertNotNil(viewModel.tempUserSession)
        XCTAssertTrue(viewModel.didAuthenticateUser)
    }
    
    func testLoginSuccess() {
        let mockAuthRepository = MockAuthRepositoryImpl()
        let viewModel = AuthViewModel(authRepository: mockAuthRepository)

        viewModel.email = "kubotayosuke@gmail.com"
        viewModel.password = "1111"

        viewModel.login()

        XCTAssertNotNil(viewModel.userSession)
        XCTAssertEqual(viewModel.userSession?.email, "kubotayosuke@gmail.com")
    }
    
    func testLoginFail() {
        let mockAuthRepository = MockAuthRepositoryImpl()
        let viewModel = AuthViewModel(authRepository: mockAuthRepository)

        viewModel.email = "invalid_email@gmail.com"
        viewModel.password = "invalid_password"
                
        viewModel.login()
        
        XCTAssertNil(viewModel.userSession)
    }
    
    func testLogout() {
        let mockAuthRepository = MockAuthRepositoryImpl()
        let viewModel = AuthViewModel(authRepository: mockAuthRepository)

        viewModel.email = "kubotayosuke@gmail.com"
        viewModel.password = "1111"

        viewModel.login()

        XCTAssertNotNil(viewModel.userSession)
        XCTAssertEqual(viewModel.userSession?.email, "kubotayosuke@gmail.com")
        
        viewModel.logout()
        XCTAssertNil(viewModel.userSession)
    }
    
    func testUploadProfileImage() {
        let mockUserRepository = MockUserRepositoryImpl()
        mockUserRepository.uploadUserImageResult = .success(true)
        
        let viewModel = AuthViewModel(userRepository: mockUserRepository)
        
        guard let testImage = UIImage(named: "test_image") else { return }
        
        viewModel.uploadProfileImage(testImage)
        
        XCTAssertTrue(viewModel.userSession != nil)
    }
    
    func testUploadImage() {
        let mockStorageRepository = MockStorageRepository()
        ImageUploader.initialize(storageRepository: mockStorageRepository)

        mockStorageRepository.uploadDataResult = .success("https://example.com/image.jpg")
                
        guard let testImage = UIImage(named: "test_image") else { return }
        
        ImageUploader.uploadImage(testImage) { result in
            switch result {
            case .success(let imageURL):
                XCTAssertEqual(imageURL, "https://example.com/image.jpg")
            case .failure(let error):
                XCTFail("Upload failed with error: \(error.localizedDescription)")
            }
        }
    }
    

    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        measure {
            
        }
    }
}


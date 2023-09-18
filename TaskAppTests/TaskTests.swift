//
//  TaskTests.swift
//  TaskAppTests
//
//  Created by 久保田陽介 on 2023/09/14.
//

import XCTest
@testable import TaskApp

final class TaskTests: XCTestCase {
    override func setUpWithError() throws {
        
    }
    override func tearDownWithError() throws {
        
    }

    class MockTaskRepositoryImpl: TaskRepository {
        var saveCalled = false
        var savedTask: Task?
        
        var deletedTaskId: String?
        var deleteCompletionResult: Result<Bool, Error>?
        
        func save(_ task: TaskApp.Task, _ taskId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
            saveCalled = true
            savedTask = task
        }
        
        func update(_ task: TaskApp.Task, _ taskId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
            saveCalled = true
            savedTask = task
        }
        
        func toggle(_ task: TaskApp.Task, _: String, completion: @escaping (Result<Bool, Error>) -> Void) {
            saveCalled = true
            savedTask = task
        }
        
        func delete(_ taskId: String, _ userId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
            deletedTaskId = taskId
            if let result = deleteCompletionResult {
                completion(result)
            }
        }
    }
    
    
    func testTaskSave() {
        let mockTaskRepository = MockTaskRepositoryImpl()
        let viewModel = NewTaskViewViewModel(taskRepository: mockTaskRepository)
        
        viewModel.title = "title"
        viewModel.category = .work
        viewModel.dueDate = Date()
        
        let expectation = XCTestExpectation(description: "Save Task")
        
        viewModel.save()
        
        XCTAssertTrue(mockTaskRepository.saveCalled)
        XCTAssertNotNil(mockTaskRepository.savedTask)
    }
    
    func testTaskUpdate() {
        let mockTaskRepository = MockTaskRepositoryImpl()
        let viewModel = UpdateTaskViewViewModel(taskRepository: mockTaskRepository)
        
        let taskId = "testTaskId"
        
        viewModel.title = "title"
        viewModel.category = .work
        viewModel.dueDate = Date()
        
        viewModel.update(id: taskId)
        
        XCTAssertTrue(mockTaskRepository.saveCalled)
        XCTAssertNotNil(mockTaskRepository.savedTask)
    }
    
    func testToggleTask() {
        let mockTaskRepository = MockTaskRepositoryImpl()
        let viewModel = TaskItemViewViewModel(taskRepository: mockTaskRepository)

        let testTask = Task(id: "testTaskId",
                            title: "title",
                            category: .work,
                            dueDate:Date().timeIntervalSince1970,
                            createDate: Date().timeIntervalSince1970,
                            isDone: false
                            )
        
        viewModel.toggle(task: testTask)
        
        XCTAssertTrue(mockTaskRepository.saveCalled)
        XCTAssertNotNil(mockTaskRepository.savedTask)
    }
    
    func testDeleteTask() {
        let mockTaskRepository = MockTaskRepositoryImpl()
        let viewModel = TaskListViewViewModel(userId: "testUserId", taskRepository: mockTaskRepository)
        
        let taskId = "testTaskId"
        
        viewModel.delete(id: taskId)
        
        XCTAssertEqual(mockTaskRepository.deletedTaskId, taskId)
        
        mockTaskRepository.deleteCompletionResult = .success(true)
    }
    
    func testExample() throws {

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

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
        }
    }
    
    
    func testTaskSave() {
        let mockTaskRepository = MockTaskRepositoryImpl()
        let viewModel = NewTaskViewViewModel(taskRepository: mockTaskRepository)
        
        let expectedTitle = "title"
        let expectedCategory = Category.work
        let expectedDueDate = Date()
        
        viewModel.title = expectedTitle
        viewModel.category = expectedCategory
        viewModel.dueDate = expectedDueDate
        
        let expectation = XCTestExpectation(description: "Save Task")
        
        viewModel.save()
        
        XCTAssertTrue(mockTaskRepository.saveCalled)
        
        if let savedTask = mockTaskRepository.savedTask {
            XCTAssertEqual(savedTask.title, expectedTitle)
            XCTAssertEqual(savedTask.category, expectedCategory)
            XCTAssertEqual(savedTask.dueDate, expectedDueDate.timeIntervalSince1970)
        } else {
            XCTFail("Saved task should not be nil")
        }
    }
    
    func testTaskUpdate() {
        let mockTaskRepository = MockTaskRepositoryImpl()
        let viewModel = UpdateTaskViewViewModel(taskRepository: mockTaskRepository)
        
        let taskId = "testTaskId"
        
        let expectedTitle = "Updated Task Title"
        let expectedCategory = Category.work
        let expectedDueDate = Date()
        
        viewModel.title = expectedTitle
        viewModel.category = expectedCategory
        viewModel.dueDate = expectedDueDate
        
        viewModel.update(id: taskId)
        
        XCTAssertTrue(mockTaskRepository.saveCalled)
        if let savedTask = mockTaskRepository.savedTask {
            XCTAssertEqual(savedTask.title, expectedTitle)
            XCTAssertEqual(savedTask.category, expectedCategory)
            XCTAssertEqual(savedTask.dueDate, expectedDueDate.timeIntervalSince1970)
        } else {
            XCTFail("Updated task should not be nil")
        }
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
        
        if let savedTask = mockTaskRepository.savedTask {
            XCTAssertEqual(savedTask.isDone, true)
        } else {
            XCTFail("Saved task should not be nil")
        }
    }
    
    func testDeleteTask() {
        let mockTaskRepository = MockTaskRepositoryImpl()
        let viewModel = TaskListViewViewModel(userId: "testUserId", taskRepository: mockTaskRepository)
        
        let taskId = "testTaskId"
        
        viewModel.delete(id: taskId)
        
        XCTAssertEqual(mockTaskRepository.deletedTaskId, taskId)
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

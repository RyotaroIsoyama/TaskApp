//
//  Task.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/09.
//

import Foundation

struct Task: Codable, Identifiable{
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createDate: TimeInterval
    var isDone: Bool
}

//
//  Task.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/09.
//

import Foundation

enum Category: String, Codable, CaseIterable {
    case work = "仕事"
    case housework = "家事"
    case personal = "プライベート"
    case other = "その他"
}

struct Task: Codable, Identifiable{
    let id: String
    let title: String
    var category: Category
    let dueDate: TimeInterval
    let createDate: TimeInterval
    var isDone: Bool
}

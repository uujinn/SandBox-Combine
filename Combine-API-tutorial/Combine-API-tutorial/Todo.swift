//
//  Todo.swift
//  Combine-API-tutorial
//
//  Created by 양유진 on 2022/07/12.
//

import Foundation

struct Todo: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

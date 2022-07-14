//
//  Post.swift
//  Combine-API-tutorial
//
//  Created by 양유진 on 2022/07/12.
//

import Foundation

struct Post: Codable {
  let userID, id: Int
  let title, body: String
  
  enum CodingKeys: String, CodingKey {
    case userID = "userId"
    case id, title, body
  }
}

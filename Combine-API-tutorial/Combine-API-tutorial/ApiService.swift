//
//  ApiService.swift
//  Combine-API-tutorial
//
//  Created by 양유진 on 2022/07/12.
//

import Foundation
import Combine
import Alamofire

enum API {
  case fetchTodos // Todos 가져오기
  case fetchPosts // Posts 가져오기
  case fetchUsers // User 가져오기
  
  var url: URL {
    switch self {
    case .fetchTodos:
      return URL(string: "https://jsonplaceholder.typicode.com/todos")!
    case .fetchPosts:
      return URL(string: "https://jsonplaceholder.typicode.com/posts")!
    case .fetchUsers:
      return URL(string: "https://jsonplaceholder.typicode.com/users")!
    }
  }
}

enum APIService {
  static func fetchUsers() -> AnyPublisher<[User], Error>{
    print("fetchTodos")
//    return URLSession.shared.dataTaskPublisher(for: API.fetchUsers.url)
//      .map{ $0.data }
//      .decode(type: [User].self, decoder: JSONDecoder())
//      .eraseToAnyPublisher()
    return AF.request(API.fetchUsers.url)
      .publishDecodable(type: [User].self)
      .value()
      .mapError({ (afError: AFError) in
        return afError as Error
      })
      .eraseToAnyPublisher()
  }
  
  static func fetchTodos() -> AnyPublisher<[Todo], Error>{
    print("fetchTodos")
//    return URLSession.shared.dataTaskPublisher(for: API.fetchTodos.url)
//      .map{ $0.data }
//      .decode(type: [Todo].self, decoder: JSONDecoder())
//      .eraseToAnyPublisher()
    return AF.request(API.fetchTodos.url)
      .publishDecodable(type: [Todo].self)
      .value()
      .mapError({ (afError: AFError) in
        return afError as Error
      })
      .eraseToAnyPublisher()
  }
  
  static func fetchPosts() -> AnyPublisher<[Post], Error>{
    print("fetchPosts")
//    return URLSession.shared.dataTaskPublisher(for: API.fetchPosts.url)
//      .map{ $0.data }
//      .decode(type: [Post].self, decoder: JSONDecoder())
//      .eraseToAnyPublisher()
    return AF.request(API.fetchPosts.url)
      .publishDecodable(type: [Post].self)
      .value()
      .mapError({ (afError: AFError) in
        return afError as Error
      })
      .eraseToAnyPublisher()
  }
  
  static func fetchTodosAndPostsAtTheSameTime() -> AnyPublisher<([Todo], [Post]), Error>{
    let fetchedTodos = fetchTodos()
    let fetchedPosts = fetchPosts()
    
    return Publishers
      .CombineLatest(fetchedTodos, fetchedPosts)
      .eraseToAnyPublisher()
  }

  /// Todos 호출 뒤에 그 결과로 Posts 호출하기
  static func fetchTodosAndThenPosts() -> AnyPublisher<[Post], Error> {
    return fetchTodos().flatMap { todos in // 응답의 결과를 매개변수로 넣을 수 있음
      return fetchPosts().eraseToAnyPublisher()
    }.eraseToAnyPublisher()
  }
  
  /// Todos 호출 뒤에 그 결과로 특정 조건이 성립되면  Posts 호출하기
  static func fetchTodosAndThenPostswithCondition() -> AnyPublisher<[Post], Error> {
    return fetchTodos()
      .map { $0.count } // todos.count
      .filter { $0 < 200 }
      .flatMap { todos in // 응답의 결과를 매개변수로 넣을 수 있음
      return fetchPosts().eraseToAnyPublisher()
    }.eraseToAnyPublisher()
  }
  
}

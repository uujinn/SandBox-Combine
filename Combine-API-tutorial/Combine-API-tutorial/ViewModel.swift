//
//  ViewModel.swift
//  Combine-API-tutorial
//
//  Created by 양유진 on 2022/07/12.
//

import Foundation
import Combine
import SwiftUI

class ViewModel: ObservableObject {
  
  var subscriptions = Set<AnyCancellable>()
  
  func fetchTodos() {
    APIService.fetchTodos()
      .sink { completion in
        switch completion {
        case .failure(let err):
          print("ViewModel - fetchTodos: err: \(err)")
        case .finished:
          print("ViewModel - fetchTodos: finished")
        }
      } receiveValue: { (todos: [Todo]) in
        print("todos: \(todos.count)")
      }.store(in: &subscriptions)
  }
  
  func fetchPosts() {
    APIService.fetchPosts()
      .sink { completion in
        switch completion {
        case .failure(let err):
          print("ViewModel - fetchPosts: err: \(err)")
        case .finished:
          print("ViewModel - fetchPosts: finished")
        }
      } receiveValue: { (posts: [Post]) in
        print("todos: \(posts.count)")
      }.store(in: &subscriptions)
  }
  
  func fetchTodosPosts() {
    APIService.fetchTodosAndPostsAtTheSameTime()
      .sink { completion in
        switch completion {
        case .failure(let err):
          print("ViewModel - fetchTodosPosts: err: \(err)")
        case .finished:
          print("ViewModel - fetchTodosPosts: finished")
        }
      } receiveValue: { (todos: [Todo], posts: [Post]) in
        print("todos: \(todos.count)")
        print("posts: \(posts.count)")
      }.store(in: &subscriptions)
  }
  
  // todos 호출 후 응답으로 posts 호출
  func fetchTodosAndThenPost() {
    APIService.fetchTodosAndThenPosts()
      .sink { completion in
        switch completion {
        case .failure(let err):
          print("ViewModel - fetchTodosPosts: err: \(err)")
        case .finished:
          print("ViewModel - fetchTodosPosts: finished")
        }
      } receiveValue: { (posts: [Post]) in
        print("posts: \(posts.count)")
      }.store(in: &subscriptions)
  }
  
  // todos 호출 후 응답에 따른 조건으로 posts 호출
  func fetchTodosAndThenPostswithCondition() {
    APIService.fetchTodosAndThenPostswithCondition()
      .sink { completion in
        switch completion {
        case .failure(let err):
          print("ViewModel - fetchTodosPosts: err: \(err)")
        case .finished:
          print("ViewModel - fetchTodosPosts: finished")
        }
      } receiveValue: { (posts: [Post]) in
        print("posts: \(posts.count)")
      }.store(in: &subscriptions)
  }
  
  // todos.count < 200: 포스트 호출 ? 유저 호출
  func fetchTodoAndApiCallConditinally(){
    let shouldFetchPosts: AnyPublisher<Bool, Error> =
    APIService.fetchTodos().map{ todos in
      todos.count < 200
    }.eraseToAnyPublisher()
    
    shouldFetchPosts
      .filter{ $0 == true }
      .flatMap { _ in
        return APIService.fetchPosts()
      }.sink { completion in
        switch completion {
        case .failure(let err):
          print("ViewModel - fetchTodosPosts: err: \(err)")
        case .finished:
          print("ViewModel - fetchTodosPosts: finished")
        }
      } receiveValue: { (posts: [Post]) in
        print("posts: \(posts.count)")
      }.store(in: &subscriptions)
    
    shouldFetchPosts
      .filter{ $0 != true }
      .flatMap { _ in
        return APIService.fetchUsers()
      }.sink { completion in
        switch completion {
        case .failure(let err):
          print("ViewModel - fetchTodosPosts: err: \(err)")
        case .finished:
          print("ViewModel - fetchTodosPosts: finished")
        }
      } receiveValue: { (users: [User]) in
        print("users: \(users.count)")
      }.store(in: &subscriptions)
  }
}


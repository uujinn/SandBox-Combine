//
//  ContentView.swift
//  Combine-API-tutorial
//
//  Created by 양유진 on 2022/07/12.
//

import SwiftUI

struct ContentView: View {
  
  @StateObject var viewModel = ViewModel()
  
  init() {
    self._viewModel = StateObject.init(wrappedValue: ViewModel())
  }
  
  var body: some View {
    VStack{
      Button {
        self.viewModel.fetchTodos()
      } label: {
        Text("Todos 호출")
          .foregroundColor(.white)
      }
      .padding()
      .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
      Button {
        self.viewModel.fetchPosts()
      } label: {
        Text("Posts 호출")
          .foregroundColor(.white)
      }
      .padding()
      .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
      Button {
        self.viewModel.fetchTodosPosts()
      } label: {
        Text("Todos + Posts 동시 호출")
          .foregroundColor(.white)
      }
      .padding()
      .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
    }
    Button {
      self.viewModel.fetchTodosAndThenPost()
    } label: {
      Text("Todos 호출 후 응답으로 Posts 호출")
        .foregroundColor(.white)
    }
    .padding()
    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
    Button {
      self.viewModel.fetchTodosAndThenPostswithCondition()
    } label: {
      Text("Todos 호출 후 조건에 따른 응답으로 Posts 호출")
        .foregroundColor(.white)
    }
    .padding()
    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
    
    Button {
      self.viewModel.fetchTodoAndApiCallConditinally()
    } label: {
      Text("Todos 호출 후 응답 결과에 따른 API 분기 처리")
        .foregroundColor(.white)
    }
    .padding()
    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
  }
  

}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

//
//  ViewController.swift
//  Combine_Debounce
//
//  Created by 양유진 on 2022/07/06.
//

import UIKit
import Combine

class ViewController: UIViewController {
  
  @IBOutlet weak var myLabel: UILabel!
  private lazy var searchController: UISearchController = {
    let searchController = UISearchController()
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.tintColor = .black
    searchController.searchBar.searchTextField.accessibilityIdentifier = "mySearchBarTextField"
    return searchController
  }()
  
  var mySubscription = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.navigationItem.searchController = searchController
    searchController.isActive = true
    
    searchController.searchBar.searchTextField
      .myDebounceSearchPublisher
      .sink { [weak self] (receivedValue) in
        guard let self = self else { return }
        print("receivedValue: \(receivedValue)")
        self.myLabel.text = receivedValue
      }.store(in: &mySubscription)
  }
  
  
}

extension UISearchTextField {
  var myDebounceSearchPublisher: AnyPublisher<String, Never>{
    NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: self)
    // Notification 센터에서 UISearchTextField 가져옴
      .compactMap { $0.object as? UISearchTextField }
      .map { $0.text ?? "" }
      .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
      // 글자가 있을 때만 이벤트 전달
      .filter { $0.count > 0 }
      .print()
      .eraseToAnyPublisher()
  }
}


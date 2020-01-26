//
//  TodoAppNavigation.swift
//  Todo
//
//  Created by Muis on 20/01/20.
//

import UIKit
import Router

// These below should be internal

protocol __Navigation: Navigation {
  func viewcontrollerForNavigation() -> UIViewController
  func navigate(from: UIViewController, to: UIViewController)
}

class MyAppNavigation<MyNavigation: __Navigation>: AppNavigation{
  func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
    guard let  nav = navigation as? MyNavigation else { fatalError() }
    return nav.viewcontrollerForNavigation()
  }
  
  func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
    guard let  nav = navigation as? MyNavigation else { fatalError() }
    nav.navigate(from: from, to: to)
  }
}

extension MyAppNavigation {
  func navigate(to navigation: MyNavigation, from: UIViewController) {
    Router.default.navigate(navigation, from: from)
  }
}

final class TodoAppNavigation: MyAppNavigation<TodoNavigation> {
  static let shared = TodoAppNavigation()
  
  private override init() {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    super.init()
  }
  
  let window: UIWindow
  
  func start() {
    let uiNav = UINavigationController()
    window.rootViewController = uiNav
    window.makeKeyAndVisible()
    
    Router.default.setupAppNavigation(appNavigation: self)
    navigate(to: .todos, from: uiNav)
  }
}

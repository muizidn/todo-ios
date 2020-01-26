//
//  AppNavigation.swift
//  Todo
//
//  Created by Muis on 20/01/20.
//

import Foundation
import Router

enum TodoNavigation: __Navigation {
  case todos
}

extension TodoNavigation {
  func viewcontrollerForNavigation() -> UIViewController {
    switch self {
    case .todos:
      let vc = TodosController()
      vc.viewModel = TodosViewModel()
      return vc
    }
  }
}

extension TodoNavigation {
  func navigate(from: UIViewController, to: UIViewController) {
    from.navigationPush(vc: to)
  }
}

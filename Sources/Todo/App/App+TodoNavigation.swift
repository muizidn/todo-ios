//
//  AppNavigation.swift
//  Todo
//
//  Created by Muis on 20/01/20.
//

import Foundation
import Router

extension TodoNavigation {
    static var initial: TodoNavigation { .todo }
}

enum TodoNavigation: __Navigation {
    case todos
    case todo
}

extension TodoNavigation {
    func viewcontrollerForNavigation() -> UIViewController {
        switch self {
        case .todos:
            let vc = TodosController()
            vc.viewModel = TodosViewModel()
            return vc
        case .todo:
            let vc = TodoController()
            vc.viewModel = TodoViewModel()
            return vc
        }
    }
}

extension TodoNavigation {
    func navigate(from: UIViewController, to: UIViewController) {
        from.navigationPush(vc: to)
    }
}

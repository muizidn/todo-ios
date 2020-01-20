//
//  AppNavigation.swift
//  Note
//
//  Created by Muis on 20/01/20.
//

import Foundation
import Router

enum NoteNavigation: __Navigation {
  case notes
}

extension NoteNavigation {
  func viewcontrollerForNavigation() -> UIViewController {
    switch self {
    case .notes:
      let vc = NotesController()
      vc.viewModel = NotesViewModel()
      return vc
    }
  }
}

extension NoteNavigation {
  func navigate(from: UIViewController, to: UIViewController) {
    from.navigationPush(vc: to)
  }
}

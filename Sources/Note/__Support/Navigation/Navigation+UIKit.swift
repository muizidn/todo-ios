//
//  Navigation+UIKit.swift
//  Note
//
//  Created by Muis on 20/01/20.
//

import UIKit

extension UIViewController {
  func navigationPush(vc: UIViewController, animated: Bool = true) {
    if let nav = self as? UINavigationController {
      nav.pushViewController(vc, animated: animated)
    } else {
      self.present(vc, animated: animated, completion: nil)
    }
  }
  
  @discardableResult
  func navigationPop(animated: Bool = true) -> UIViewController? {
    if let nav = self as? UINavigationController {
      return nav.popViewController(animated: animated)
    } else {
      self.dismiss(animated: animated, completion: nil)
      return self
    }
  }
}


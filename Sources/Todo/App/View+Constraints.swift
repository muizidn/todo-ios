//
//  View+Constraints.swift
//  Todo
//
//  Created by Muis on 25/01/20.
//

import UIKit

extension UIView {
  func edges(to view: UIView) {
    configure { (v) in
      v.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        v.leftAnchor.constraint(equalTo: view.leftAnchor),
        v.topAnchor.constraint(equalTo: view.topAnchor),
        v.rightAnchor.constraint(equalTo: view.rightAnchor),
        v.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      ])
    }
  }
}

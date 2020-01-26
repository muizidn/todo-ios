//
//  ViewModelType.swift
//  Todo
//
//  Created by Muis on 20/01/20.
//

import Foundation

protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  var input: Input { get }
  var output: Output { get }
}

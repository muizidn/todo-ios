//
//  View+ReusableCellProtocol.swift
//  Todo
//
//  Created by Muis on 25/01/20.
//

import Foundation
import UIKit
import RxSwift

protocol TableViewReusableCell: UITableViewCell {
  
  /* Swift doesn't allow recursive constraint
   associatedtype ViewModel: TableViewReusableCellViewModel
   where ViewModel.Cell == Self */
  
  associatedtype ViewModel: TableViewReusableCellViewModel
}

protocol TableViewReusableCellViewModel {
  associatedtype Cell: UIView
  func beginSubscription(cell: Cell, with disposeBag: DisposeBag)
}

extension TableViewReusableCell {
  static var reuseIdentifier: String { "\(Self.self)" }
}

class TableViewCell<ViewModel>: UITableViewCell, TableViewReusableCell where ViewModel: TableViewReusableCellViewModel {
  
  let stack = VStack()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.add(stack)
    commonInit()
  }
  
  func commonInit() {}
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setFlexConfig() {
    stack.flex.width(bounds.width)
    stack.flex.layout(mode: .adjustHeight)
    stack.frame.origin = .zero
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setFlexConfig()
  }
  
  override var intrinsicContentSize: CGSize {
    return stack.intrinsicContentSize
  }
  
  var viewModel: ViewModel!
  private var disposeBag = DisposeBag()
  override func prepareForReuse() {
    super.prepareForReuse()
    let bag = DisposeBag()
    viewModel.beginSubscription(cell: self as! ViewModel.Cell, with: bag)
    self.disposeBag = bag
  }
}

extension UITableView {
  func registerReusableCell<T: TableViewReusableCell>(_ t: T.Type) {
    self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
  }
  func dequeueReusableCell<T: TableViewReusableCell>(_ t: T.Type) -> T {
    self.dequeueReusableCell(withIdentifier: t.reuseIdentifier) as! T
  }
}

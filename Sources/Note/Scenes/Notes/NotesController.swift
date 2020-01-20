//  
//  NotesController.swift
//  Note
//
//  Created by Muis on 20/01/20.
//

import UIKit
import RxSwift
import RxCocoa
import Material

final class NotesController: BaseController<NotesViewModel> {
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    layoutNavBar()
    layoutUI()
    startBind()
  }
  
  // MARK: Navbar
  
  private let addBtn = UIBarButtonItem(
    barButtonSystemItem: .add, target: nil, action: nil)
  
  private func layoutNavBar() {
    navigationItem.configure { (n) in
      n.title = "Notes"
      n.rightBarButtonItem = addBtn
    }
  }
  
  // MARK: UI
  
  private let tableView = UITableView()
  
  private func layoutUI() {
    view.configure { (v) in
      v.add(tableView) { v in
        v.flex.grow(1)
          .margin(.uniform(1))
      }
    }
  }
  
  // MARK: Binding
  
  private func startBind() {
    addBtn.rx.tap
      .bind(to: viewModel.input.load)
      .disposed(by: disposeBag)
    
    viewModel.output.action
      .drive()
      .disposed(by: disposeBag)
    
    viewModel.output.error
      .map({ HUDType.error($0.localizedDescription) })
      .drive(hudBinder)
      .disposed(by: disposeBag)
    
    viewModel.output.activity
      .map({ HUDType.progress($0) })
      .drive(hudBinder)
      .disposed(by: disposeBag)
    
    viewModel.input.load.onNext(())
  }
}

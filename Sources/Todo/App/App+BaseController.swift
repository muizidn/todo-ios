//
//  BaseController.swift
//  Todo
//
//  Created by Muis on 20/01/20.
//

import UIKit
import RxCocoa

class BaseController<ViewModel>: UIViewController {
  var viewModel: ViewModel!
  
  let root = FlexView()
  
  override func loadView() {
    super.loadView()
    view = root
    root.isPaddingWithSafeArea = true
  }
  
  private lazy var hud = ControllerHUD(vc: self)
  private(set) lazy var hudBinder = Binder<HUDType>(hud) { (hud, type) in
      hud.set(hud: type)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      hud.set(hud: .hide)
  }
}

//
//  BaseController.swift
//  Note
//
//  Created by Muis on 20/01/20.
//

import UIKit
import RxCocoa

class BaseController<ViewModel>: UIViewController {
  var viewModel: ViewModel!
  
  override func loadView() {
    super.loadView()
    view = FlexView()
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

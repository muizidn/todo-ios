//
//  BaseController.swift
//  Todo
//
//  Created by Muis on 20/01/20.
//

import RxCocoa

class BaseController: UIViewController {
    let root = FlexView()
    
    override func loadView() {
        super.loadView()
        view = root
    }
    
    func layoutUI() {}
    
    private lazy var hud = ControllerHUD(vc: self)
    private(set) lazy var hudBinder = Binder<HUDType>(hud) { (hud, type) in
        hud.set(hud: type)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hud.set(hud: .hide)
    }
}

protocol InterfaceBuilderController: UIViewController {
    static var nibName: String { get }
    static var bundle: Bundle? { get }
}

extension InterfaceBuilderController {
    static var nibName: String { "\(Self.self)" }
    static var bundle: Bundle? { nil }
}

private extension InterfaceBuilderController {
    static func create() -> Self {
        Self.init(nibName: nibName, bundle: bundle)
    }
}

class XibBaseController<C>: BaseController where C: InterfaceBuilderController {
    private(set) var xibController: C!
    
    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        let vc = C.create()
        addChild(vc)
        root.add(vc.view) { v in
            v.flex.grow(1)
        }
        vc.didMove(toParent: self)
        xibController = vc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

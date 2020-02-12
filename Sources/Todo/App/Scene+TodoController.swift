//  
//  Scene+TodoController.swift
//  Todo
//
//  Created by Muis on 25/01/20.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa
import Material

final class TodoXibController: UIViewController, InterfaceBuilderController {
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfPlace: UITextField!
    @IBOutlet weak var switchRemindDay: UISwitch!
    @IBOutlet weak var tfAlarm: UITextField!
    @IBOutlet weak var btnAddImage: UIButton!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var btnAddTodo: UIControl!
}

final class TodoController: XibBaseController<TodoXibController> {
    var viewModel: TodoViewModel!
    private let disposeBag = DisposeBag()
    
    private lazy var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutNavBar()
        layoutUI()
        startBind()
    }
    
    // MARK: Navbar
    
    private func layoutNavBar() {
        navigationController?.isNavigationBarHidden = true
        navigationItem.configure { (n) in
            
        }
    }
    
    // MARK: UI
    
    override func layoutUI() {
        xib.tfAlarm.inputView = datePicker
    }
    
    // MARK: Binding
    
    private func startBind() {
        
        xib.btnAddImage.rx.tap
            .flatMapLatest({ [unowned self] in
                Observable<UIImage?>.create({ (o)  in
                    let vc = UIImagePickerController()
                    vc.allowsEditing = true
                    vc.delegate = self
                    self.present(vc, animated: true, completion: nil)
                    return Disposables.create {
                        vc.dismiss(animated: true, completion: nil)
                    }
                })
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        xib.btnAddTodo.rx.controlEvent(.touchUpInside)
            .withLatestFrom(Observable
                .combineLatest(
                    xib.tfTitle.rx.text.orEmpty,
                    xib.tfPlace.rx.text.orEmpty,
                    xib.switchRemindDay.rx.value,
                    datePicker.rx.date)
                .map({ [unowned self] args in
                    Todo(uuid: "",
                         title: args.0,
                         place: args.1,
                         reminder: args.2 ? args.3 : nil,
                         image: self.xib.imgImage.image)
                }))
            .bind(to: viewModel.input.create)
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

extension TodoController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
    }
}


struct Todo {
    let uuid: String
    let title: String
    let place: String
    let reminder: Date?
    let image: Image?
}

typealias Image = UIImage

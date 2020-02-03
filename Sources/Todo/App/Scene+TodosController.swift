//  
//  Scene+TodosController.swift
//  Todo
//
//  Created by Muis on 25/01/20.
//

import UIKit
import RxSwift
import RxCocoa
import Material

final class TodosXibController: UIViewController, InterfaceBuilderController {}
final class TodosController: XibBaseController<TodosXibController> {
    var viewModel: TodosViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutNavBar()
//        layoutUI()
        startBind()
    }
    
    // MARK: Navbar
    private let refreshControl = UIRefreshControl()
    
    private func layoutNavBar() {
        navigationItem.configure { (n) in
            n.title = "TUDU List"
            n.largeTitleDisplayMode = .automatic
        }
        navigationController?.navigationBar.configure({ (n) in
            n.prefersLargeTitles = true
        })
    }
    
    // MARK: UI
    
    private lazy var tableView = UITableView().configure { (v) in
        v.dataSource = self
        v.delegate = self
        v.registerReusableCell(TodoCell.self)
        v.separatorStyle = .singleLine
        v.refreshControl = self.refreshControl
    }
    var dataSource = [Pb_Todo]() {
        didSet {
            tableView.reloadData()
            tableView.setNeedsLayout()
            //      for d in dataSource {
            //        stack.add { (v: VStack) in
            //          v.add { (v: UILabel) in
            //            v.text = d.title
            //            v.textAlignment = .center
            //          }
            //          v.add { (v: UILabel) in
            //            v.text = d.description_p
            //            v.lineBreakMode = .byWordWrapping
            //            v.numberOfLines = 0
            //          }
            //        }
            //      }
            //      root.setNeedsLayout()
        }
    }
    
    let stack = VStack()
    
    override func layoutUI() {
        root.configure { (v) in
            v.add(stack) { v in
                v.flex.grow(1)
//                v.add(self.tableView) { (v) in
//                    v.flex.grow(1)
//                    v.separatorStyle = .none
//                }
                v.add { (v: __Classify) in
                    v.flex
                        .grow(1)
                        .height(48)
                    v.image.image = UIImage(named: "inbox")
                    v.title.text = "Inbox"
                    v.counter.text = "0"
                }
                v.add { (v: __Classify) in
                    v.image.image = UIImage(named: "inbox")
                    v.title.text = "Inbox"
                    v.counter.text = "0"
                }
                v.add { (v: __Classify) in
                    v.image.image = UIImage(named: "inbox")
                    v.title.text = "Inbox"
                    v.counter.text = "0"
                }
                v.add { (v: UIView) in
                    v.backgroundColor = .red
                }
                v.add { (v: UITabBar) in
                    v.flex
                        .height(88)
                        .width(80%)
                        .alignSelf(.center)
                    
                    v.isTranslucent = false
//                    v.backgroundColor = .xRomantic
                    v.barTintColor = .xRomantic
                }
            }
        }
        
        
        //    root.layoutIfNeeded()
    }
    
    // MARK: Binding
    
    private func startBind() {
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.load)
            .disposed(by: disposeBag)
        
        viewModel.output.dataSource
            .drive(onNext: { [unowned self] ds in
                self.dataSource = ds
            })
            .disposed(by: disposeBag)
        
        viewModel.output.action
            .drive()
            .disposed(by: disposeBag)
        
        viewModel.output.error
            .map({ HUDType.error($0.localizedDescription) })
            .drive(hudBinder)
            .disposed(by: disposeBag)
        
        viewModel.output.activity
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        //    viewModel.input.load.onNext(())
    }
}

final class __Classify: HStack {
    let image = UIImageView()
    let title = UILabel()
    let counter = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flex.padding(5)
        
        add(image) { v in
            v.flex.aspectRatio(1)
                .marginLeft(20)
        }
        add(title) { v in
            v.flex.grow(1)
        }
        add(counter) { v in
            v.flex.grow(1)
        }
    }
}

extension TodosController: UITableViewDataSource {
    
    func getTag(_ tb: UITableView, idx: IndexPath) -> Int {
        tb.hashValue + idx.hashValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(TodoCell.self)
        cell.viewModel = .init(todo: dataSource[indexPath.row])
        cell.prepareForReuse()
        cell.tag = getTag(tableView, idx: indexPath)
        return cell
    }
}

extension TodosController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView
            .viewWithTag(getTag(tableView, idx: indexPath))!
        cell.frame.size = .init(width: tableView.frame.width, height: 0)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let height = cell.intrinsicContentSize.height
        return height
    }
}

fileprivate final class TodoCell: TableViewCell<TodoCell.ViewModel> {
    fileprivate(set) var lbTitle = UILabel()
    fileprivate(set) var lbDescription = UILabel() {
        didSet {
            lbDescription.configure { (v) in
                v.lineBreakMode = .byWordWrapping
                v.numberOfLines = 0
            }
        }
    }
    
    override func prepareForReuse() {
        lbTitle.removeFromSuperview()
        lbDescription.removeFromSuperview()
        
        lbTitle = UILabel()
        lbDescription = UILabel()
        
        stack.add(lbTitle)
        stack.add(lbDescription)
        super.prepareForReuse()
    }
    
    fileprivate struct ViewModel: TableViewReusableCellViewModel {
        let todo: Pb_Todo
        func beginSubscription(cell: TodoCell, with disposeBag: DisposeBag) {
            print(cell.tag,cell.lbDescription.frame)
            cell.lbTitle.text = todo.title
            cell.lbDescription.text = todo.description_p
        }
    }
}

extension IndexPath {
    var asTag: Int { row }
}

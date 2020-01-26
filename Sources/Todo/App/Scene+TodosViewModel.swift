//  
//  Scene+TodosViewModel.swift
//  Todo
//
//  Created by Muis on 25/01/20.
//

import Foundation
import RxSwift
import RxCocoa

final class TodosViewModel: ViewModelType {
  let input: Input
  let output: Output
  
  struct Input {
    let load: AnyObserver<Void>
    let delete: AnyObserver<String>
  }
  
  struct Output {
    let dataSource: Driver<[Pb_Todo]>
    let action: Driver<Void>
    let error: Driver<Error>
    let activity: Driver<Bool>
  }
  
  init() {
    let sLoad = PublishSubject<Void>()
    let sDelete = PublishSubject<String>()
    let errorTracker = ErrorTracker()
    let activityIndicator = ActivityIndicator()
    
    input = Input(
      load: sLoad.asObserver(),
      delete: sDelete.asObserver()
    )
    
    let dataSourceServer = sLoad
      .flatMapLatest({
        ServiceTodo.shared.rx.list()
          .trackError(errorTracker)
          .trackActivity(activityIndicator)
          .catchErrorJustCompleted()
      })
    
    let actionDelete = sDelete
      .flatMapLatest({
        ServiceTodo.shared.rx.delete(uuid: $0)
          .trackError(errorTracker)
          .trackActivity(activityIndicator)
          .catchErrorJustCompleted()
      })
      .mapToVoid()
    
    let dataSource = Observable
      .merge(
        dataSourceServer
    )
      .map({ $0.todos })
    
    let action = Observable<Void>
      .merge(
        actionDelete
    )
    
    output = Output(
      dataSource: dataSource.asDriverOnErrorJustComplete(),
      action: action.asDriverOnErrorJustComplete(),
      error: errorTracker.asDriver(),
      activity: activityIndicator.asDriver()
    )
  }
}

//  
//  Scene+TodoViewModel.swift
//  Todo
//
//  Created by Muis on 25/01/20.
//

import Foundation
import RxSwift
import RxCocoa

final class TodoViewModel: ViewModelType {
  let input: Input
  let output: Output
  
  struct Input {
    let load: AnyObserver<Void>
    let create: AnyObserver<Pb_TodoCreate>
    let update: AnyObserver<Pb_Todo>
  }
  
  struct Output {
    let action: Driver<Void>
    let error: Driver<Error>
    let activity: Driver<Bool>
  }
  
  init() {
    let sLoad = PublishSubject<Void>()
    let sCreate = PublishSubject<Pb_TodoCreate>()
    let sUpdate = PublishSubject<Pb_Todo>()
    
    let errorTracker = ErrorTracker()
    let activityIndicator = ActivityIndicator()
    
    input = Input(
      load: sLoad.asObserver(),
      create: sCreate.asObserver(),
      update: sUpdate.asObserver()
    )
    
    let action = Observable<Void>.merge()
    
    output = Output(
      action: action.asDriverOnErrorJustComplete(),
      error: errorTracker.asDriver(),
      activity: activityIndicator.asDriver()
    )
  }
}

//  
//  NotesViewModel.swift
//  Note
//
//  Created by Muis on 20/01/20.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftProtobuf

final class NotesViewModel: ViewModelType {
  let input: Input
  let output: Output
  
  struct Input {
    let load: AnyObserver<Void>
  }
  
  struct Output {
    let action: Driver<Void>
    let error: Driver<Error>
    let activity: Driver<Bool>
  }
  
  init() {
    let sLoad = PublishSubject<Void>()
    
    let errorTracker = ErrorTracker()
    let activityIndicator = ActivityIndicator()
    
    input = Input(
      load: sLoad.asObserver()
    )
    
    let item = sLoad
      .flatMapLatest({
        URLSession.init(configuration: .ephemeral)
          .rx.data(request: URLRequest.init(url: URL(string: "http://127.0.0.1:5000/currentUser")!))
          .map({ data in Result<Contact, Error>(
            catching: { try Contact.init(serializedData: data) }) })
          .debug("reply", trimOutput: false)
          .trackError(errorTracker)
          .trackActivity(activityIndicator)
          .catchErrorJustCompleted()
      })
    
    let action = Observable<Void>.merge(
      item.mapToVoid()
    )
    
    output = Output(
      action: action.asDriverOnErrorJustComplete(),
      error: errorTracker.asDriver(),
      activity: activityIndicator.asDriver()
    )
  }
}

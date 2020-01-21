//  
//  NotesViewModel.swift
//  Note
//
//  Created by Muis on 20/01/20.
//

import Foundation
import RxSwift
import RxCocoa
import GRPC
import NIO

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
        Observable<String>.create { (o) in
          let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
          let config = ClientConnection.Configuration(
            target: .hostAndPort("localhost", 50051),
            eventLoopGroup: group
          )
          
          let conn = ClientConnection(configuration: config)
          let client = Helloworld_GreeterServiceClient.init(connection: conn)
          let call = client.sayHello(.with({
            $0.name = "Muis"
          }))
          call.response.whenComplete { (res) in
            switch res {
            case .success(let resp):
              o.onNext(resp.message)
              o.onCompleted()
            case .failure(let err):
              o.onError(err)
            }
          }
          return Disposables.create()
        }
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

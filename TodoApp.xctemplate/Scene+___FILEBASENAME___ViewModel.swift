//  ___FILEHEADER___

import Foundation
import RxSwift
import RxCocoa

final class ___VARIABLE_productName:identifier___ViewModel: ViewModelType {
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
    
    let action = Observable<Void>.merge()
    
    output = Output(
      action: action.asDriverOnErrorJustComplete(),
      error: errorTracker.asDriver(),
      activity: activityIndicator.asDriver()
    )
  }
}
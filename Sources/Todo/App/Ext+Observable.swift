import RxSwift
import RxCocoa

extension ObservableType {
  func asDriverOnErrorJustComplete() -> Driver<Element> {
    asDriver { error in Driver.empty() }
  }
  
  func mapToVoid() -> Observable<Void> {
    map({ _ in })
  }
}

extension ObservableConvertibleType {
    func trackError(_ tracker: ErrorTracker) -> Observable<Element> {
        return tracker.trackError(from: self)
    }
    
    func catchErrorCompleted(with tracker: ErrorTracker) -> Observable<Element> {
        return tracker
            .trackError(from: self)
            .catchError({ _ in .empty() })
    }
}

extension ObservableConvertibleType {
    func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<Element> {
        return activityIndicator.track(source: self)
    }
}

extension ObservableConvertibleType {
    func catchErrorJustCompleted() -> Observable<Element> {
        return asObservable().catchError({ _ in Observable.empty() })
    }
}

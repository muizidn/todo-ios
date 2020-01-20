import UIKit
import RxSwift
import RxCocoa
import Router

final class AppDelegate: UIResponder, UIApplicationDelegate {
  
  private let disposeBag = DisposeBag()
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    NoteAppNavigation.shared.start()
    return true
  }
  
}

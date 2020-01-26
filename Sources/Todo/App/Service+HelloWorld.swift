import Foundation
import RxSwift
import GRPC

extension Pb_GreeterServiceClient: BackendServiceClient {}

final class ServiceHelloWorld {
  static let shared = ServiceHelloWorld()
  fileprivate let client = ServiceBackend
    .makeClient(Pb_GreeterServiceClient.self,
                opts: try! CallOptions(timeout: .seconds(10)))
}

extension ServiceHelloWorld: ReactiveCompatible {}

extension Reactive where Base == ServiceHelloWorld {
  func sayHello(name: String) -> Observable<String> {
    Observable<Pb_HelloReply>.create { (o) in
      let call = self.base.client.sayHello(.with({
        $0.name = name
      }))
      fnUnaryCall(call: call, observer: o)
      return Disposables.create()
    }
    .map { $0.message }
  }
}

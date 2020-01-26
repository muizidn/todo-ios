import Foundation
import RxSwift
import GRPC
import SwiftProtobuf

extension Pb_TodoServiceServiceClient: BackendServiceClient {}

final class ServiceTodo {
  static let shared = ServiceTodo()
  fileprivate let client = ServiceBackend
    .makeClient(Pb_TodoServiceServiceClient.self,
                opts: try! CallOptions(timeout: .seconds(10)))
}

extension ServiceTodo: ReactiveCompatible {}

extension Reactive where Base == ServiceTodo {
  func create(title: String, description: String = "") -> Observable<Pb_Todo> {
    rpcUnaryCall(base.client.create, req: Pb_TodoCreate.with({
      $0.title = title
      $0.description_p = description
    }))
  }
  func list() -> Observable<Pb_TodoList> {
    rpcUnaryCall(base.client.list, req: SwiftProtobuf.Google_Protobuf_Empty.init())
  }
  func get(uuid: String) -> Observable<Pb_Todo> {
    rpcUnaryCall(base.client.get, req: Pb_TodoIdentifier.with({
      $0.uuid = uuid
    }))
  }
  func update(uuid: String, title: String, description: String = "") -> Observable<Pb_Todo> {
    rpcUnaryCall(base.client.update, req: Pb_Todo.with({
      $0.id = Pb_TodoIdentifier.with({ $0.uuid = uuid })
      $0.title = title
      $0.description_p = description
    }))
  }
  func delete(uuid: String) -> Observable<Pb_Status> {
    rpcUnaryCall(base.client.delete, req: Pb_TodoIdentifier.with({
      $0.uuid = uuid
    }))
  }
}

import Foundation
import RxSwift
import GRPC
import SwiftProtobuf

@inlinable
func fnUnaryCall<Req, Resp>(call: UnaryCall<Req, Resp>, observer o: AnyObserver<Resp>) where Req: SwiftProtobuf.Message, Resp: SwiftProtobuf.Message {
  call.response.whenComplete { (res) in
    switch res {
    case .success(let resp):
      o.onNext(resp)
      o.onCompleted()
    case .failure(let err):
      if let status = err as? GRPCStatus {
        o.onError(status)
      }
      o.onError(err)
    }
  }
}

@inlinable
func rpcUnaryCall<Req, Resp>(_ fn: @escaping (Req, CallOptions?) -> UnaryCall<Req, Resp>, req: Req, callOptions: CallOptions? = nil) -> Observable<Resp> where Req: SwiftProtobuf.Message, Resp: SwiftProtobuf.Message  {
  Observable<Resp>.create { (o) in
    let call = fn(req, callOptions)
    call.response.whenComplete { (res) in
      switch res {
      case .success(let resp):
        o.onNext(resp)
        o.onCompleted()
      case .failure(let err):
        if let status = err as? GRPCStatus {
          o.onError(status)
        }
        o.onError(err)
      }
    }
    return Disposables.create()
  }
}


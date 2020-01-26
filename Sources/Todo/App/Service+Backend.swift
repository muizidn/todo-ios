import Foundation
import GRPC
import NIO

final class ServiceBackend: ConnectivityStateDelegate {
  static let shared = ServiceBackend()
  private init() {}
  #if DEBUG
  private var host = "localhost"
  #else
  #error("set this!")
  #endif
  private(set) lazy var connection: ClientConnection = {
    let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    let config = ClientConnection.Configuration(
      target: .hostAndPort(host, 50051),
      eventLoopGroup: group
    )
    
    let conn = ClientConnection(configuration: config)
    conn.connectivity.delegate = self
    return conn
  }()
  
  static func makeClient<T: BackendServiceClient>(_ t: T.Type, opts: CallOptions = CallOptions()) -> T {
    return T(connection: Self.shared.connection, defaultCallOptions: opts)
  }
  
  func connectivityStateDidChange(from oldState: ConnectivityState, to newState: ConnectivityState) {
    print("ConnState: \(oldState) => \(newState)")
  }
}

protocol BackendServiceClient {
  init(connection: ClientConnection, defaultCallOptions: CallOptions)
}

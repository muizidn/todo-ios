_frameworks = {}

def combine_deps(name,frameworks):
    prebuilt_apple_frameworks = []
    for framework in frameworks:
        native.prebuilt_apple_framework(name=framework,
                            framework="Build/iOS/%s.framework" % framework,
                            preferred_linkage="shared",
                            visibility=["PUBLIC"])
        prebuilt_apple_frameworks.append("//Carthage:%s" % framework)
    
    _frameworks[name] = prebuilt_apple_frameworks

def resolve_deps(name):
    return _frameworks[name]

def register_deps(name, frameworks):
    if _frameworks.get(name) != None:
        return
    combine_deps(name, frameworks)

def carthage_deps():
    initialize_deps()
    return (
        resolve_deps("Texture") +
        resolve_deps("GRPC") +
        resolve_deps("RxSwift") +
        resolve_deps("ViewDSL") +
        resolve_deps("FlexLayout") +
        resolve_deps("Router") +
        resolve_deps("Material") +
        resolve_deps("JGProgressHUD") +
        resolve_deps("IQKeyboardManager")
    )


def initialize_deps():
    register_deps(
        name = "RxSwift",
        frameworks = ["RxSwift", "RxCocoa", "RxRelay", ]
    )

    register_deps(
        name = "GRPC",
        frameworks = ["GRPC", "CNIOAtomics", "CNIOBoringSSL", "CNIOBoringSSLShims", "CNIODarwin", "CNIOHTTPParser", "CNIOLinux", "CNIOSHA1", "Logging", "NIO", "NIOConcurrencyHelpers", "NIOFoundationCompat", "NIOHPACK", "NIOHTTP1", "NIOHTTP2", "NIOSSL", "NIOTLS", "NIOTransportServices", "SwiftProtobuf", ]
    )

    register_deps(
        name = "Texture",
        frameworks = ["AsyncDisplayKit", "PINCache", "PINRemoteImage", "PINOperation"]
    )

    register_deps(
        name = "Material",
        frameworks = ["Material", "Motion", ]
    )

    register_deps(
        name = "Router",
        frameworks = ["Router"]
    )

    register_deps(
        name = "ViewDSL",
        frameworks = ["ViewDSL"]
    )

    register_deps(
        name = "FlexLayout",
        frameworks = ["FlexLayout"]
    )

    register_deps(
        name = "JGProgressHUD",
        frameworks = ["JGProgressHUD"]
    )

    register_deps(
        name = "IQKeyboardManager",
        frameworks = ["IQKeyboardManager"]
    )
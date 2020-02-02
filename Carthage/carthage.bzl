_frameworks = {}

def combined_deps(name,frameworks):
    prebuilt_apple_frameworks = []
    for framework in frameworks:
        native.prebuilt_apple_framework(name=framework,
                            framework="Build/iOS/%s.framework" % framework,
                            preferred_linkage='static',
                            visibility=['PUBLIC'])
        prebuilt_apple_frameworks.append("//Carthage:%s" % framework)
    
    _frameworks[name] = prebuilt_apple_frameworks

def resolve_deps(name):
    return _frameworks[name]


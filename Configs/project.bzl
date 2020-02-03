def xclist(*args):
    configs = ""
    for arg in args:
        configs = configs + " %s" % arg
    return configs

_configs = {
    # Plist
    "DEVELOPMENT_TEAM" : 'SDSLU2QT5X',
    "BUNDLE_PREFIX" : 'com.muiz.idn',
    "PRODUCT_BUNDLE_IDENTIFIER" : 'com.muiz.idn.todo.ios',
    "PRODUCT_NAME" : 'TodoApp',
    "KEYCHAIN_GROUP" : 'SDSLU2QT5X.com.muiz.idn.todo.ios',
    "APP_BUILD_VERSION" : '1.0',
    "APP_BUILD_NUMBER" : '1',
    # Buck
    "INFOPLIST_FILE": "Sources/Todo/Info.plist",
    # Xcode Configs
    "IPHONEOS_DEPLOYMENT_TARGET": "%s" % native.read_config("apple", "iphoneos_target_sdk_version"),
    "SDKROOT": "iphoneos",
    "GCC_OPTIMIZATION_LEVEL": "0",
    "SWIFT_WHOLE_MODULE_OPTIMIZATION": "YES",
    "ONLY_ACTIVE_ARCH": "YES",
    "LD_RUNPATH_SEARCH_PATHS": "@executable_path/Frameworks",
    "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES",
    "DEVELOPMENT_LANGUAGE": "en",
    "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
    "OTHER_LDFLAGS": "$(inherited) -all_load",
    "OTHER_SWIFT_FLAGS": xclist("$(inherited)"),
    "EXECUTABLE_NAME": "TodoApp"
}

def config(key):
    return _configs[key]

def get(key, *strings):
    return { key : _configs[key] + xclist(*strings) }

# https://stackoverflow.com/a/26853961
def merge(*dict_args):
    """
    Given any number of dicts, shallow copy and merge into a new dict,
    precedence goes to key value pairs in latter dicts.
    """
    result = {}
    for dictionary in dict_args:
        result.update(dictionary)
    return result

def project_configs():
    debug = merge(
        get("PRODUCT_BUNDLE_IDENTIFIER"),
        get("SDKROOT"),
        get("IPHONEOS_DEPLOYMENT_TARGET"),
        get("APP_BUILD_VERSION"),
        get("APP_BUILD_NUMBER"),
        get("OTHER_SWIFT_FLAGS", "-DDEBUG"),
    )
    profile = merge(
        # get("PRODUCT_BUNDLE_IDENTIFIER"),
        # get("SDKROOT"),
        # get("IPHONEOS_DEPLOYMENT_TARGET"),
        # get("APP_BUILD_VERSION"),
        # get("APP_BUILD_NUMBER"),
        # get("OTHER_SWIFT_FLAGS", "-DDEBUG"),
    )
    release = merge(
    )
    final_configs = {
        "Debug": debug,
        "Profile": profile,
        "Release": release
    }
    return final_configs

def project_info_plist_substitutions():
    return merge(
        get("DEVELOPMENT_LANGUAGE"),
        get("PRODUCT_BUNDLE_IDENTIFIER"),
        get("APP_BUILD_VERSION"),
        get("APP_BUILD_NUMBER"),
        get("KEYCHAIN_GROUP"),
    )



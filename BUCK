load("//Configs:configs.bzl", "app_configs")
load("//Configs:project.bzl", "config" ,"project_configs", "project_info_plist_substitutions")

apple_binary(
  name = 'TodoBin',
  configs = project_configs(),
  swift_version = '5',
  srcs = glob([
    'Sources/Todo/*.swift',
    'Sources/Todo/App/*.swift',
    'pb/*.swift'
  ]),
  deps = [
    "//Carthage:CarthageDeps"
  ]
)

apple_resource(
    name = "TodoResources",
    dirs = [
      "Sources/Todo/Assets.xcassets"
    ],
    files = glob([
      "Sources/Todo/**/*.xib",
      ])
)

apple_bundle(
    name = "TodoApp",
    extension = "app",
    binary = ":TodoBin",
    product_name = "TodoApp",
    info_plist = config("INFOPLIST_FILE"),
    info_plist_substitutions = project_info_plist_substitutions(),
    deps = [
      "//Carthage:CarthageDeps",
      "//:TodoResources"
    ]
)

apple_package(
  name = 'TodoIpa',
  bundle = ':TodoApp',
)

xcode_workspace_config (
    name = "Workspace",
    workspace_name = "TodoApp",
    src_target = ":TodoApp",
)
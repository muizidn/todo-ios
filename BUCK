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

apple_bundle(
    name = "TodoApp",
    extension = "app",
    binary = ":TodoBin",
    product_name = "TodoApp",
    info_plist = config("INFOPLIST_FILE"),
    info_plist_substitutions = project_info_plist_substitutions(),
    deps = [
      "//Carthage:CarthageDeps"
    ]
)

apple_package(
  name = 'TodoIpa',
  bundle = ':TodoApp',
)

xcode_workspace_config (
    name = "Workspace",
    workspace_name = "Todo",
    src_target = ":TodoApp",
    # action_config_names = None,
    # additional_scheme_actions = None,
    # compatible_with = None,
    # default_target_platform = None,
    # environment_variables = None,
    # explicit_runnable_path = None,
    # extra_schemes = None,
    # extra_shallow_targets = None,
    # extra_targets = None,
    # extra_tests = None,
    # is_remote_runnable = None,
    # labels = None,
    # launch_style = None,
    # licenses = None,
    # notification_payload_file = None,
    # target_compatible_with = None,
    # was_created_for_app_extension = None,
    # watch_interface = None,
)
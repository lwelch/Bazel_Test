
# For a DLL/Shared Library, we link it into a shared object. Therefore, we use cc_binary.
cc_binary(
    name = "sharedLib",
    deps = [":sharedLibApi",],
    srcs = [
        "mySharedLib.c",
    ],
    includes = [],
    defines = ["COMPILING_DLL"],
    # To Create a DLL/Shared Library, we need to set linkshared to True and linkstatic to False
    linkshared = True,
    linkstatic = False,
    visibility = ["//visibility:public"],
)

# Get the import library for the dll
# This is needed for linking at linktime
filegroup(
    name = "sharedImportLib",
    srcs = [":sharedLib"],
    output_group = "interface_library",
    visibility = ["//visibility:public"],
)

# We still need to export the headers so that the user can reference them
# when linking at linktime.
cc_library(
    name = "sharedLibApi",
    deps = [],
    srcs = [],
    hdrs = ["mySharedLib.h",],
    strip_include_prefix = "//shared_lib",
    defines =
        select({
            "@bazel_config//:window-clang":["WINDOWS_OS"],
            "@bazel_config//:linux-clang":["LINUX_OS"],
            "//conditions:default": [],
        }),
    visibility = ["//visibility:public"],
)


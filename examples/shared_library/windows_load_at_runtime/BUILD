
# Windows Runtime Link option
cc_binary(
    name = "addRuntimeLink",
    deps = [
    ],
    # When we link at runtime instead of linktime,
    # the dll gets included as part of the data object
    data = ["//shared_lib:sharedLib"],
    srcs = [
        "main.c",
    ],
    includes = [],

)
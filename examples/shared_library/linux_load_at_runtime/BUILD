
# Linux Runtime Link option
cc_binary(
    name = "addRuntimeLink",
    deps = [
    ],
    # When we link at runtime instead of linktime,
    # the dll gets included as part of the data object
    data = ["//shared_lib:sharedLib"],
    # Need to add the -ldl flag to tell the compiler to link the dynamic libraries in
    linkopts = ["-ldl"],
    srcs = [
        "main.c",
    ],
    includes = [],

)

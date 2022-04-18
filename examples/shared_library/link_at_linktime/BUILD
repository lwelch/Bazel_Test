
# Here, we import the DLL/Shared Library we need to use via the cc_import command.
cc_import(
    name = "shareLibImport",
    interface_library = "@//shared_lib:sharedImportLib",
    shared_library = "//shared_lib:sharedLib",
)

# Finally, we build our executable binary to run.
cc_binary(
    name = "add",
    # When we link at linktime, the dll gets included as part
    # of the deps object from the cc_import command above
    deps = [
        ":shareLibImport",
        "//examples/shared_library/shared_lib:sharedLibApi",
    ],
    srcs = [
        "main.c",
    ],
    includes = [],

)

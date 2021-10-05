load(":cc_toolchain_config.bzl", "cc_toolchain_config")

package(default_visibility = ["//visibility:public"])

cc_toolchain_suite(
    name = "diab_suite",
    toolchains = {
        "AWR294x": ":DiabCompiler_toolchain",
        "AWR294x|DiabCompiler": ":DiabCompiler_toolchain",
        "AWR294x|TiCompiler": ":TiCompiler_toolchain"
    },
)

filegroup(name = "empty")

cc_toolchain(
    name = "DiabCompiler_toolchain",
    toolchain_identifier = "DiabCompiler-toolchain",
    toolchain_config = ":DiabCompiler_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)

cc_toolchain_config(name = "DiabCompiler_toolchain_config")

cc_toolchain(
    name = "TiCompiler_toolchain",
    toolchain_identifier = "TiCompiler-toolchain",
    toolchain_config = ":TiCompiler_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)

cc_toolchain_config(name = "TiCompiler_toolchain_config")
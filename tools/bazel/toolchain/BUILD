load(":cc_toolchain_config.bzl", "cc_toolchain_config")

package(default_visibility = ["//visibility:public"])

cc_toolchain_suite(
    name = "ti_suite",
    toolchains = {
        "AWR294x": ":ti_arm_windows_toolchain",
        "AWR294x|TiWindows": ":ti_arm_windows_toolchain",
        "AWR294x|TiLinux": ":ti_arm_linux_toolchain"
    },
)

filegroup(name = "empty")

cc_toolchain(
    name = "ti_arm_windows_toolchain",
    toolchain_identifier = "TiWindows-toolchain",
    toolchain_config = ":ti_arm_windows_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)

cc_toolchain_config(name = "ti_arm_windows_toolchain_config")

cc_toolchain(
    name = "ti_arm_linux_toolchain",
    toolchain_identifier = "ti-arm-linux-toolchain",
    toolchain_config = ":ti_arm_linux_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)

cc_toolchain_config(name = "ti_arm_linux_toolchain_config")

load(":ti_toolchain_config.bzl", "ti_toolchain_config")

package(default_visibility = ["//visibility:public"])

config_setting(
    name = "on_linux",
    constraint_values = [
        "@platforms//os:linux",
    ],
)

config_setting(
    name = "on_windows",
    constraint_values = [
        "@platforms//os:windows",
    ],
)

cc_toolchain_suite(
    name = "ti_suite",
    toolchains = {
        "ti-arm": ":ti_arm_toolchain",
        "ti-c66": ":ti_c66_toolchain",
    },
)

filegroup(name = "empty")

cc_toolchain(
    name = "ti_arm_toolchain",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
    toolchain_config = ":ti_arm_toolchain_config",
    toolchain_identifier = "TiArm-toolchain",
)

ti_toolchain_config(
    name = "ti_arm_toolchain_config",
    os = select({
        ":on_windows": "windows",
        ":on_linux": "linux",
    }),
)

cc_toolchain(
    name = "ti_c66_toolchain",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
    toolchain_config = ":ti_c66_toolchain_config",
    toolchain_identifier = "TiC66-toolchain",
)

ti_toolchain_config(
    name = "ti_c66_toolchain_config",
    os = select({
        ":on_windows": "windows",
        ":on_linux": "linux",
    }),
)

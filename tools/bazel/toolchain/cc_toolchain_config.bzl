
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "tool_path")

def _impl(ctx):
    if ctx.attr.name == "ti_arm_linux_toolchain_config":
        toolchain_identifier = "ti-arm-linux-toolchain"
        compiler = "TiArmLinux"
        cxx_builtin_include_directories = [
            "/ti/ti-cgt-armllvm_1.3.0.LTS/include/c",
            "/ti/ti-cgt-armllvm_1.3.0.LTS/include/c++/v1",
            "/ti/ti-cgt-armllvm_1.3.0.LTS/lib/clang/12.0.1/include",
        ]

        tool_paths = [
            tool_path(
                name = "gcc",
                path = "/ti/ti-cgt-armllvm_1.3.0.LTS/bin/tiarmclang",
            ),
            tool_path(
                name = "ld",
                path = "/usr/bin/ld",
            ),
            tool_path(
                name = "ar",
                path = "/ti/ti-cgt-armllvm_1.3.0.LTS/bin/tiarmar",
            ),
            tool_path(
                name = "cpp",
                path = "/bin/false",
            ),
            tool_path(
                name = "gcov",
                path = "/ti/ti-cgt-armllvm_1.3.0.LTS/bin/tiarmcov",
            ),
            tool_path(
                name = "nm",
                path = "/ti/ti-cgt-armllvm_1.3.0.LTS/bin/tiarmnm",
            ),
            tool_path(
                name = "objdump",
                path = "/ti/ti-cgt-armllvm_1.3.0.LTS/bin/tiarmobjdump",
            ),
            tool_path(
                name = "strip",
                path = "/ti/ti-cgt-armllvm_1.3.0.LTS/bin/tiarmstrip",
            ),
        ]
    elif ctx.attr.name == "ti_arm_windows_toolchain_config":
        toolchain_identifier = "ti-arm-windows-toolchain"
        compiler = "TiArmWindows"
        cxx_builtin_include_directories = [
            "C:/ti/ti-cgt-armllvm_1.3.0.LTS/include/c",
            "C:/ti/ti-cgt-armllvm_1.3.0.LTS/include/c++/v1",
            "C:/ti/ti-cgt-armllvm_1.3.0.LTS/lib/clang/12.0.1/include",
        ]

        tool_paths = [
            tool_path(
                name = "gcc",
                path = "C:/ti/ti-cgt-armllvm_1.3.0.LTS/bin/tiarmclang",
            ),
            tool_path(
                name = "ld",
                path = "/usr/bin/ld",
            ),
            tool_path(
                name = "ar",
                path = "C:/ti/ti-cgt-armllvm_1.3.0.LTS/bin/tiarmar",
            ),
            tool_path(
                name = "cpp",
                path = "/bin/false",
            ),
            tool_path(
                name = "gcov",
                path = "C:/ti/ti-cgt-armllvm_1.3.0.LTS/bin/tiarmcov",
            ),
            tool_path(
                name = "nm",
                path = "C:/ti/ti-cgt-armllvm_1.3.0.LTS/bin/tiarmnm",
            ),
            tool_path(
                name = "objdump",
                path = "C:/ti/ti-cgt-armllvm_1.3.0.LTS/bin/tiarmobjdump",
            ),
            tool_path(
                name = "strip",
                path = "C:/ti/ti-cgt-armllvm_1.3.0.LTS/bin/tiarmstrip",
            ),
        ]
    else:
        toolchain_identifier = ""
        compiler = ""
        cxx_builtin_include_directories = []
        tool_paths = []
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        cxx_builtin_include_directories = cxx_builtin_include_directories,
        toolchain_identifier = toolchain_identifier,
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "AWR294x",
        target_libc = "unknown",
        compiler = compiler,
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
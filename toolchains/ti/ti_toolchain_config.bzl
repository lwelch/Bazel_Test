load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature", "flag_group", "flag_set", "tool_path", "variable_with_value")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("//tools/bazel/toolchain:ti_compiler_flags.bzl", "arm_asm_flags", "arm_c_flags", "arm_cpp_flags", "arm_linker_flags", "c66_asm_flags", "c66_c_flags", "c66_cpp_flags", "c66_linker_flags")

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]
c_compile_actions = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cc_flags_make_variable,
]
cpp_compile_actions = [
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.cc_flags_make_variable,
]

cpp_assemble_actions = [
    ACTION_NAMES.assemble,
    ACTION_NAMES.cc_flags_make_variable,
]

def _impl(ctx):
    if ctx.attr.name == "ti_arm_toolchain_config":
        if ctx.attr.os == "windows":
            compiler_base_dir = "C:/ti/ti-cgt-armllvm_1.3.1.LTS"
        elif ctx.attr.os == "linux":
            compiler_base_dir = "/ti/ti-cgt-armllvm_1.3.1.LTS"
        else:
            compiler_base_dir = ""
        target_cpu = "ti-arm"
        toolchain_identifier = "ti-arm-toolchain"
        compiler = "TiArm"
        cxx_builtin_include_directories = [
            compiler_base_dir + "/include/c",
            compiler_base_dir + "/include/c++/v1",
            compiler_base_dir + "/lib/clang/12.0.1/include",
        ]
        tool_paths = [
            tool_path(
                name = "gcc",
                path = compiler_base_dir + "/bin/tiarmclang",
            ),
            tool_path(
                name = "ld",
                path = compiler_base_dir + "/bin/tiarmlnk",
            ),
            tool_path(
                name = "ar",
                path = compiler_base_dir + "/bin/tiarmar",
            ),
            tool_path(
                name = "cpp",
                path = "/bin/false",
            ),
            tool_path(
                name = "gcov",
                path = compiler_base_dir + "/bin/tiarmcov",
            ),
            tool_path(
                name = "nm",
                path = compiler_base_dir + "/bin/tiarmnm",
            ),
            tool_path(
                name = "objdump",
                path = compiler_base_dir + "/bin/tiarmobjdump",
            ),
            tool_path(
                name = "strip",
                path = compiler_base_dir + "/bin/tiarmstrip",
            ),
        ]
        features = [
            feature(
                name = "default_c_compiler_flags",
                enabled = True,
                flag_sets = [
                    flag_set(
                        actions = c_compile_actions,
                        flag_groups = ([
                            flag_group(
                                flags = arm_c_flags(),
                            ),
                        ]),
                    ),
                ],
            ),
            feature(
                name = "default_cpp_compiler_flags",
                enabled = True,
                flag_sets = [
                    flag_set(
                        actions = cpp_compile_actions,
                        flag_groups = ([
                            flag_group(
                                flags = arm_cpp_flags(),
                            ),
                        ]),
                    ),
                ],
            ),
            feature(
                name = "default_asm_compiler_flags",
                enabled = True,
                flag_sets = [
                    flag_set(
                        actions = cpp_assemble_actions,
                        flag_groups = ([
                            flag_group(
                                flags = arm_asm_flags(),
                            ),
                        ]),
                    ),
                ],
            ),
            feature(
                name = "default_linker_flags",
                enabled = True,
                flag_sets = [
                    flag_set(
                        actions = all_link_actions,
                        flag_groups = ([
                            flag_group(
                                flags = arm_linker_flags(compiler_base_dir),
                            ),
                        ]),
                    ),
                ],
            ),
            # this removes flag -Wl,-S
            feature(
                name = "strip_debug_symbols",
                flag_sets = [
                    flag_set(
                        actions = all_link_actions,
                        flag_groups = [],
                    ),
                ],
            ),
            feature(
                name = "output_execpath_flags",
                flag_sets = [
                    flag_set(
                        actions = [ACTION_NAMES.cpp_link_executable],
                        flag_groups = [
                            flag_group(
                                flags = [
                                    "-o%{output_execpath}",
                                    "-Wl,--map_file=%{output_execpath}.map",
                                ],
                            ),
                        ],
                    ),
                ],
            ),
        ]
    elif ctx.attr.name == "ti_c66_toolchain_config":
        if ctx.attr.os == "windows":
            compiler_base_dir = "C:/ti/ti-cgt-c6000_8.3.7"
        elif ctx.attr.os == "linux":
            compiler_base_dir = "/ti/ti-cgt-c6000_8.3.7"
        else:
            compiler_base_dir = ""
        target_cpu = "c66"
        toolchain_identifier = "ti-c66-toolchain"
        compiler = "TiC66"
        cxx_builtin_include_directories = [
            compiler_base_dir + "/include",
            # compiler_base_dir + "/include/c++/v1",
            # compiler_base_dir + "/lib/clang/12.0.1/include",
        ]

        tool_paths = [
            tool_path(
                name = "gcc",
                path = compiler_base_dir + "/bin/cl6x",
            ),
            tool_path(
                name = "ld",
                path = compiler_base_dir + "/bin/tiarmlnk",
            ),
            tool_path(
                name = "ar",
                path = compiler_base_dir + "/bin/ar6x",
            ),
            tool_path(
                name = "cpp",
                path = "/bin/false",
            ),
            tool_path(
                name = "gcov",
                path = compiler_base_dir + "/bin/tiarmcov",
            ),
            tool_path(
                name = "nm",
                path = compiler_base_dir + "/bin/tiarmnm",
            ),
            tool_path(
                name = "objdump",
                path = compiler_base_dir + "/bin/tiarmobjdump",
            ),
            tool_path(
                name = "strip",
                path = compiler_base_dir + "/bin/tiarmstrip",
            ),
        ]
        archiver_flags_feature = feature(
            name = "archiver_flags",
            flag_sets = [
                flag_set(
                    actions = [ACTION_NAMES.cpp_link_static_library],
                    flag_groups = [
                        flag_group(
                            flags = ["r", "%{output_execpath}"],
                            expand_if_available = "output_execpath",
                        ),
                    ],
                ),
                flag_set(
                    actions = [ACTION_NAMES.cpp_link_static_library],
                    flag_groups = [
                        flag_group(
                            iterate_over = "libraries_to_link",
                            flag_groups = [
                                flag_group(
                                    flags = ["%{libraries_to_link.name}"],
                                    expand_if_equal = variable_with_value(
                                        name = "libraries_to_link.type",
                                        value = "object_file",
                                    ),
                                ),
                                flag_group(
                                    flags = ["%{libraries_to_link.object_files}"],
                                    iterate_over = "libraries_to_link.object_files",
                                    expand_if_equal = variable_with_value(
                                        name = "libraries_to_link.type",
                                        value = "object_file_group",
                                    ),
                                ),
                                flag_group(
                                    flags = ["%{libraries_to_link.static_library}"],
                                    iterate_over = "libraries_to_link.static_library",
                                    expand_if_equal = variable_with_value(
                                        name = "libraries_to_link.type",
                                        value = "static_library",
                                    ),
                                ),
                            ],
                            expand_if_available = "libraries_to_link",
                        ),
                    ],
                ),
            ],
        )

        # this removes flag -Wl,-S
        strip_debug_symbols_feature = feature(
            name = "strip_debug_symbols",
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = [],
                ),
            ],
        )
        include_paths_feature = feature(
            name = "include_paths",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = c_compile_actions,
                    flag_groups = [
                        flag_group(
                            flags = ["-I%{quote_include_paths}"],
                            iterate_over = "quote_include_paths",
                        ),
                        flag_group(
                            flags = ["-I%{include_paths}"],
                            iterate_over = "include_paths",
                        ),
                        flag_group(
                            flags = ["-I%{system_include_paths}"],
                            iterate_over = "system_include_paths",
                        ),
                        flag_group(
                            flags = ["-I" + compiler_base_dir + "/include"],
                        ),
                    ],
                ),
            ],
        )
        dependency_file_feature = feature(
            name = "dependency_file",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [
                        ACTION_NAMES.assemble,
                        ACTION_NAMES.preprocess_assemble,
                        ACTION_NAMES.c_compile,
                        ACTION_NAMES.cpp_compile,
                        ACTION_NAMES.cpp_module_compile,
                        ACTION_NAMES.objc_compile,
                        ACTION_NAMES.objcpp_compile,
                        ACTION_NAMES.cpp_header_parsing,
                        ACTION_NAMES.clif_match,
                        ACTION_NAMES.cc_flags_make_variable,
                    ],
                    flag_groups = [
                        flag_group(
                            flags = ["--preproc_dependency=%{dependency_file}"],
                            expand_if_available = "dependency_file",
                        ),
                    ],
                ),
            ],
        )
        compiler_output_flags_feature = feature(
            name = "compiler_output_flags",
            flag_sets = [
                flag_set(
                    actions = c_compile_actions + [ACTION_NAMES.assemble],
                    flag_groups = [
                        flag_group(
                            flag_groups = [
                                flag_group(
                                    flags = ["--output_file=%{output_file}"],
                                    expand_if_available = "output_file",
                                ),
                            ],
                        ),
                    ],
                ),
            ],
        )
        default_c_compiler_flags_feature = feature(
            name = "default_c_compiler_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = c_compile_actions,
                    flag_groups = ([
                        flag_group(
                            flags = c66_c_flags(),
                        ),
                    ]),
                ),
            ],
        )
        default_cpp_compiler_flags_feature = feature(
            name = "default_cpp_compiler_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = cpp_compile_actions,
                    flag_groups = ([
                        flag_group(
                            flags = c66_cpp_flags(),
                        ),
                    ]),
                ),
            ],
        )
        default_asm_compiler_flags_feature = feature(
            name = "default_asm_compiler_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = cpp_assemble_actions,
                    flag_groups = ([
                        flag_group(
                            flags = c66_asm_flags(),
                        ),
                    ]),
                ),
            ],
        )
        default_linker_flags_feature = feature(
            name = "default_linker_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = ([
                        flag_group(
                            flags = c66_linker_flags(compiler_base_dir),
                        ),
                    ]),
                ),
            ],
        )
        libraries_to_link_feature = feature(
            name = "libraries_to_link",
            flag_sets = [
                flag_set(
                    actions = [ACTION_NAMES.cpp_link_executable],
                    flag_groups = [
                        flag_group(
                            iterate_over = "libraries_to_link",
                            flag_groups = [
                                flag_group(
                                    flags = ["-l%{libraries_to_link.name}"],
                                    expand_if_equal = variable_with_value(
                                        name = "libraries_to_link.type",
                                        value = "static_library",
                                    ),
                                ),
                                flag_group(
                                    flags = ["%{libraries_to_link.name}"],
                                    expand_if_equal = variable_with_value(
                                        name = "libraries_to_link.type",
                                        value = "object_file",
                                    ),
                                ),
                            ],
                            expand_if_available = "libraries_to_link",
                        ),
                    ],
                ),
            ],
        )
        linker_param_file_feature = feature(
            name = "linker_param_file",
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = [
                        flag_group(
                            flags = ["-l%{linker_param_file}"],
                            expand_if_available = "linker_param_file",
                        ),
                    ],
                ),
            ],
        )
        user_link_flags_feature = feature(
            name = "user_link_flags",
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = [
                        flag_group(
                            iterate_over = "user_link_flags",
                            flags = ["%{user_link_flags}"],
                            expand_if_available = "user_link_flags",
                        ),
                    ],
                ),
            ],
        )
        output_execpath_flags_feature = feature(
            name = "output_execpath_flags",
            flag_sets = [
                flag_set(
                    actions = [ACTION_NAMES.cpp_link_executable],
                    flag_groups = [
                        flag_group(
                            flags = [
                                "-o%{output_execpath}",
                                "-m%{output_execpath}.map",
                            ],
                        ),
                    ],
                ),
            ],
        )
        features = [
            archiver_flags_feature,
            dependency_file_feature,
            default_c_compiler_flags_feature,
            default_cpp_compiler_flags_feature,
            default_asm_compiler_flags_feature,
            strip_debug_symbols_feature,
            include_paths_feature,
            compiler_output_flags_feature,
            default_linker_flags_feature,
            libraries_to_link_feature,
            linker_param_file_feature,
            user_link_flags_feature,
            output_execpath_flags_feature,
        ]
    else:
        target_cpu = ""
        toolchain_identifier = ""
        compiler = ""
        cxx_builtin_include_directories = []
        compiler_base_dir = ""
        tool_paths = []
        features = []

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        cxx_builtin_include_directories = cxx_builtin_include_directories,
        toolchain_identifier = toolchain_identifier,
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = target_cpu,
        target_libc = "unknown",
        compiler = compiler,
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
    )

ti_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "os": attr.string(mandatory = True, values = ["windows", "linux"]),
    },
    provides = [CcToolchainConfigInfo],
)

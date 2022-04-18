# Each compiler needs its own config_setting, so
# we can make select statements based on what compiler
# we are using.

config_setting(
    name = "ti-arm",
    values = {"cpu": "ti-arm"},
)
config_setting(
    name = "ti-c66",
    values = {"cpu": "ti-c66"},
)

config_setting(
    name = "linux-clang",
    values = {
        "define": "linux-clang=True"
    },
)

config_setting(
    name = "window-clang",
    values = {"compiler": "clang-cl"},
)

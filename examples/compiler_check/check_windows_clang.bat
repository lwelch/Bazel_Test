
@echo off
@REM # Build the C66 binary
..\..\bazelisk.exe build //:compilerCheck.elf --config=win_clang_config

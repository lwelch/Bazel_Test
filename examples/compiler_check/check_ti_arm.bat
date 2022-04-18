
@echo off
@REM # Build the Clang binary
..\..\bazelisk.exe build @compiler_check//:compilerCheck.elf --config=ti_arm_config

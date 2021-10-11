@echo off
if not exist "C:\ti\compiler\ti-cgt-armllvm_1.3.0.LTS" (
   python "../tools/python/toolsInit.py" "--ti"
)
bazel build --config=diab_config //main:hello-world
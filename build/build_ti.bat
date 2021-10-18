@echo off
if not exist "C:\ti\ti-cgt-armllvm_1.3.0.LTS" (
   python "../tools/python/toolsInit.py" "--ti"
)
bazelisk build --config=windows_config //main:hello-world
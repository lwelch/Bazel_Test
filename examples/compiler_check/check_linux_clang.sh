
if [[ $# -eq 0 ]] ; then
    echo 'Must provide the version of Clang you have installed on your Linux machine'
    echo 'Supported versions are 11, 12, 13, and 14'
    exit 1
elif [[ $1 == 11 ]] ; then
    ../../bazelisk 'build' '//:compilerCheck.elf' '--config=unix_clang11_config'
elif [[ $1 == 12 ]] ; then
    ../../bazelisk 'build' '//:compilerCheck.elf' '--config=unix_clang12_config'
elif [[ $1 == 13 ]] ; then
    ../../bazelisk 'build' '//:compilerCheck.elf' '--config=unix_clang13_config'
elif [[ $1 == 14 ]] ; then
    ../../bazelisk 'build' '//:compilerCheck.elf' '--config=unix_clang14_config'
fi


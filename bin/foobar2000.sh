#!/bin/bash
declare -a args
for arg; do
    if [[ "${arg:0:1}" = "-" ]]; then
        args+=("${arg/#-//}")
    else
        args+=("$(winepath -w "$arg")")
    fi
done
wine ~/.wine/drive_c/Program\ Files\ \(x86\)/foobar2000/foobar2000.exe "${args[@]}"
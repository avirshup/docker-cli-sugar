#!/bin/sh
initfile=/tmp/dutil/shellinit

if (command -v bash >/dev/null 2>&1) then
    export SHELL=bash
    bash --init-file ${initfile}
else
    if [ -z "${ENV}" ]; then
        export ENV=${initfile}
        export SHELL=dash
    else
        echo "Not setting up sh shell environment - \$ENV is already set"
    fi
    sh
fi

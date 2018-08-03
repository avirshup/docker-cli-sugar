#!/bin/sh
initfile=/tmp/dutil/shellinit
inputrcfile=/tmp/dutil/inputrc

if (command -v bash >/dev/null 2>&1) then
    export SHELL=bash
    if [ -z $INPUTRC ] && [ ! -f $HOME/.inputrc ]; then
        export INPUTRC=${inputrcfile}
    fi

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

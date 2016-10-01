#!/bin/bash
ROOT="`pwd`"
BASEPATH="${ROOT}/mongodb"
if [ ! -d "${BASEPATH}" ]; then
    mkdir -p "${BASEPATH}"
    mkdir -p "${BASEPATH}/db"
fi
exec mongod --dbpath "${BASEPATH}/db"

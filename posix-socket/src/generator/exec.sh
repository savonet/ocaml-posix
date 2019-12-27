#!/bin/sh

SYSTEM=$1
CMD=$2
ARG=$3

if test "${SYSTEM}" = "mingw"; then
  wine $CMD $ARG
elif test "${SYSTEM}" = "mingw64"; then
  wine64 $CMD $ARG
else
  $CMD $ARG
fi

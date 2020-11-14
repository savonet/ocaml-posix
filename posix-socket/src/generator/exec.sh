#!/bin/sh

SYSTEM=$1
CMD=$2
ARG1=$3
ARG2=$4

if test "${SYSTEM}" = "mingw"; then
  wine $CMD $ARG1 $ARG2
elif test "${SYSTEM}" = "mingw64"; then
  wine64 $CMD $ARG1 $ARG2
else
  $CMD $ARG1 $ARG2
fi

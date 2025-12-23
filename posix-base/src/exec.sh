#!/bin/sh

SYSTEM=$1
CMD=$2
ARG=$3

if test "${SYSTEM}" = "mingw"; then
  wine $CMD $ARG
elif test "${SYSTEM}" = "mingw64"; then
  if command -v wine64 > /dev/null 2>&1; then
    wine64 $CMD $ARG
  else
    wine $CMD $ARG
  fi
else
  $CMD $ARG
fi

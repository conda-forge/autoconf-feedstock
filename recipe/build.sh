#!/bin/sh

./configure --prefix=${PREFIX}        \
            --libdir=${PREFIX}/lib    \
            --build=${BUILD}          \
            --host=${HOST}            \
            PERL='/usr/bin/env perl'

make -j${CPU_COUNT} ${VERBOSE_AT}
if [[ "$build_platform" == "$target_platform" ]]; then
  make check || { cat tests/testsuite.log; exit 1; }
fi
make install

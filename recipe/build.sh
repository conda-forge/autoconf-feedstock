#!/bin/bash

set -euxo pipefail

pushd build-aux
  cp ${BUILD_PREFIX}/share/gnuconfig/config.* .
popd

./configure --prefix=${PREFIX}        \
            --libdir=${PREFIX}/lib    \
            --build=${BUILD}          \
            --host=${HOST}            \
            PERL="${PREFIX}/bin/perl"

make -j${CPU_COUNT}
if [[ "$build_platform" == "$target_platform" ]]; then
  make check || { cat tests/testsuite.log; exit 1; }
fi
make install

sed -i.bak "s@${BUILD_PREFIX}/bin/m4@${PREFIX}/bin/m4@g" ${PREFIX}/bin/autom4te
rm ${PREFIX}/bin/autom4te.bak

sed -i.bak "s@${BUILD_PREFIX}/bin/m4@${PREFIX}/bin/m4@g" ${PREFIX}/bin/autoupdate
rm ${PREFIX}/bin/autoupdate.bak

#!/bin/sh

./configure --prefix=$PREFIX
make
make check
make install

# replace shebang lines with #!/$PREFIX/bin/perl
# as conda does not handle the default shebang lines correctly
FIRST_LINE="#!${PREFIX}/bin/perl"
sed -i "1s~.*~${FIRST_LINE}~" $PREFIX/bin/autoheader
sed -i "1s~.*~${FIRST_LINE}~" $PREFIX/bin/autom4te
sed -i "1s~.*~${FIRST_LINE}~" $PREFIX/bin/autoreconf
sed -i "1s~.*~${FIRST_LINE}~" $PREFIX/bin/autoscan
sed -i "1s~.*~${FIRST_LINE}~" $PREFIX/bin/autoupdate
sed -i "1s~.*~${FIRST_LINE}~" $PREFIX/bin/ifnames

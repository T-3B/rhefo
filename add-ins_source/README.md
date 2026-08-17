## GhostScript
`gs` is forced to be 9.05 because of pdfsizeopt.

```sh
CC=clang CXX=clang++ CFLAGS='-std=gnu11 -mtune=generic -flto -O3 -static' CXXFLAGS='-std=gnu++11 -mtune=generic -flto -O3 -static' LDFLAGS='-static -flto' ./configure --disable-contrib --disable-dynamic --disable-cups --disable-gtk --disable-fontconfig --disable-dbus --without-x
make -j
strip -s bin/gs
upx -9 --ultra-brute bin/gs
```

## Python 2.7.12
`python2.7` is currently x86 i386 (32bit!), provided by pdfsizeopt. Should be made 64bit (TODO).

Cannot `upx` it.

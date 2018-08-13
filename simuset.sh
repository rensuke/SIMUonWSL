#!/bin/bash

#==========================================
# Arch Linuxのbase-develパッケージのインストール
# witchは入れられないので下記には記していない
#==========================================
yes | sudo apt-get install autoconf automake binutils bison fakeroot file findutils flex gawk gcc gettext grep groff gzip libtool m4 make pacman patch pkg-config sed sudo texinfo util-linux

#=========================================
# 他追加パッケージ群
# gitは開発版git cloneで使用
#=========================================
yes | sudo apt-get install nsis mingw-w64 git


#====================================
# zip系のセットアップ
#====================================

#====================================
# zlib-1.2.11
#====================================
cd /usr/local/src
sudo wget http://zlib.net/zlib-1.2.11.tar.gz
sudo tar xvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
# ここから下Hiroyuki-Nagata氏のサイト参考に設定
PREFIXDIR=/usr/x86_64-w64-mingw32
sudo make -f win32/Makefile.gcc BINARY_PATH=$PREFIXDIR/bin INCLUDE_PATH=$PREFIXDIR/include LIBRARY_PATH=$PREFIXDIR/lib SHARED_MODE=1 PREFIX=x86_64-w64-mingw32- install


#====================================
# bzip2-1.0.6
#====================================
cd /usr/local/src
sudo wget http://archive.ubuntu.com/ubuntu/pool/main/b/bzip2/bzip2_1.0.6.orig.tar.bz2
sudo tar xvf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6
# ここから下、絶対領域氏のパッチファイル内容とサイト内で紹介されていたコマンド
sudo sed -i 's|sys\\stat.h|sys/stat.h|g' bzip2.c
sudo sed -i 's|CC=gcc|CC=x86_64-w64-mingw32-gcc|g' Makefile
sudo sed -i 's|AR=ar|AR=x86_64-w64-mingw32-ar|g' Makefile
sudo sed -i 's|RANLIB=ranlib|RANLIB=x86_64-w64-mingw32-ranlib|g' Makefile
sudo sed -i 's|PREFIX=/usr/local|PREFIX=/usr/x86_64-w64-mingw32|g' Makefile
sudo make libbz2.a
sudo install -m 644 bzlib.h /usr/x86_64-w64-mingw32/include
sudo install -m 644 libbz2.a /usr/x86_64-w64-mingw32/lib


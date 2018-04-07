#!/usr/bin/env bash

version=${1?"Falta la versión de bioplat a empaquetar"}

product_root_folder=bioplat

cp -r ../$product_root_folder . > /dev/null

x86_64=org.bioplat.app.product-macosx.cocoa.x86_64.zip

mkdir -p bioplat.app/Contents/MacOS
tar xf jre.tar.gz
cp -r jre1.8.0_161.jre/Contents/Home bioplat.app/Contents/MacOS/jre > /dev/null
cp -r $product_root_folder/* bioplat.app/Contents/MacOS/ > /dev/null
cp run-bioplat bioplat.app/Contents/MacOS/ > /dev/null

zip --quiet -ur $x86_64 bioplat.app/Contents/MacOS/ 

unzip -q $x86_64 bioplat.app/Contents/Eclipse/bioplat.ini
#apunto la jre configurando:
#-vm
#packaged/path/to/libjli.dylib
sed -i '1s/^/-vm\njre\/lib\/jli\/libjli\.dylib\n/' bioplat.app/Contents/Eclipse/bioplat.ini
#ajusto la db ver run-bioplat
sed -i 's|\./db|/tmp|' bioplat.app/Contents/Eclipse/bioplat.ini

zip --quiet -u $x86_64 bioplat.app/Contents/Eclipse/bioplat.ini > /dev/null

#cambio el launcher, el default no encuentra la base de datos!
file=bioplat.app/Contents/Info.plist
unzip -q $x86_64 $file
sed -i '/<key>CFBundleExecutable<\/key>/!b;n;c<string>run-bioplat</string>' $file
zip --quiet -u $x86_64 $file


mv -v $x86_64 /tmp/bioplat-$version-macosx.cocoa.x86_64.zip

rm -rf $product_root_folder bioplat.app jre1.8.0_161.jre > /dev/null

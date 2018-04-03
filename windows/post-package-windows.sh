#!/usr/bin/env bash

version=${1?"Falta la versión de bioplat a empaquetar"}

product_root_folder=bioplat

cp -r ../$product_root_folder . > /dev/null

x86=org.bioplat.app.product-win32.win32.x86.zip
if [ -e $x86  ];then
  zip --quiet -ur $x86 $product_root_folder
  mv -v $x86 /tmp/bioplat-$version-win32.x86.zip
fi

x86_64=org.bioplat.app.product-win32.win32.x86_64.zip
unzip -q jre.zip -d $product_root_folder/ 
zip --quiet -ur $x86_64 $product_root_folder/
mv -v $x86_64 /tmp/bioplat-$version-win32.x86_64.zip


rm -rf $product_root_folder > /dev/null

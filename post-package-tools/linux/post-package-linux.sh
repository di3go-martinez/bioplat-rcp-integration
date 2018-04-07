#!/usr/bin/env bash

version=${1?"Falta la versión de bioplat a empaquetar"}

product_root_folder=bioplat

cp -r ../$product_root_folder . > /dev/null

#para x86 no se va a generar la versión, auntque no habría impedimentos a apriori
x86=org.bioplat.app.product-linux.gtk.x86.zip
if [ -e  $x86 ];then
  zip --quiet -ur $x86 $product_root_folder
  mv -v $x86 /tmp/bioplat-$version-linux.gtk.x86.zip
fi

x86_64=org.bioplat.app.product-linux.gtk.x86_64.zip
tar xf jre.tar.gz
mv jre1.8.0_161-x86_64 $product_root_folder/jre > /dev/null
#acá agrego la base de datos y otro archivos
zip --quiet -ur $x86_64 $product_root_folder/
mv -v $x86_64 /tmp/bioplat-$version-linux.gtk.x86_64.zip


rm -rf $product_root_folder > /dev/null

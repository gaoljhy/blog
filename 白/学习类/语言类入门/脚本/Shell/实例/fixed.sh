#!/bin/sh
echo "input oldsuffix"
read oldsuffix
echo "input newsuffix"
read newsuffix

dir=$(eval pwd)

for file in $(ls $dir | grep .${oldsuffix})
    do
        name=$(ls ${file} | cut -d. -f1)
        mv $file ${name}.${newsuffix}
    done
echo "change file  successd!"

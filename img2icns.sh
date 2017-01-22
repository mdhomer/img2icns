#img2icns.sh
#written by Mitchell D. Homer 2017.
#https://mdhomer.github.io

#!/bin/bash
output=$2
dir=$output'.iconset' # temp directory
file=$1 # input file name
savetemp=0 # save temporary .iconset folder
if (($3 == 1)); then savetemp=1; fi

sizes=(16 16 32 32 128 128 256 256 512)

function makeCopyWithSize {
    if (($2 == 1))
    then newfile='icon_'$1'x'$1'@2x.png'; size=$(($1*2))
    else newfile='icon_'$1'x'$1'.png'; size=$1
    fi
    sips -z $size $size $file --out $dir/$newfile
}

if [ $file ] && [ $output ]
then
    'mkdir' $dir
    prev=0
    for i in ${sizes[@]}; do
        double=0
        if (($prev == $i))
        then double=1
        fi
        makeCopyWithSize $i $double
        prev=$i
    done
    cp $file $dir/icon_512x512@2x.png
    iconutil -c icns $dir
    if (($savetemp == 0)); then rm -R $dir; fi
    echo ''
    echo 'Saved as:' $output'.icns'
else
    echo 'Incorrect args: <1024x1024 input image> <prefix of icns output>'
    echo 'eg.' $0 'file1024.png MyIcon'
fi

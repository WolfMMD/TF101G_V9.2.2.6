#!/bin/sh
echo "...............................................................Cleaning up...................................................................."
rm kern.blob
echo "...............................................................Compiling kernel..............................................................."
make -j6
echo "...............................................................Building new ramdisk..........................................................."
cd blob/kern.blob.LNX.dir/kern.blob.LNX-ramdisk.dir
find . | cpio -o -H newc | gzip > ../kern.blob.LNX-ramdisk.gz
echo "...............................................................Making new boot image.........................................................."
cd ..
../../mkbootimg --kernel ../../arch/arm/boot/zImage --base 0x10000000 --pagesize 2048 --ramdisk kern.blob.LNX-ramdisk.gz -o ../kern.blob.LNX
echo "...............................................................Making new flashable blob......................................................"
cd ..
../blobpack ../kern.blob LNX kern.blob.LNX
cd ..
echo "...............................................................Cleaning up...................................................................."
rm blob/kern.blob.LNX.dir/kern.blob.LNX-ramdisk.gz
rm blob/kern.blob.LNX
echo "...............................................................Showing blob & compiled modules................................................"
find . -name "kern.blob"
find . -name "*.ko"


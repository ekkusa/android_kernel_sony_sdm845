#!/bin/bash

clear

echo $''
echo $'     /\                       (_)'
echo $'    /  \   ___ _   _ _ __ ___  _ '
echo $'   / /\ \ / __| | | | `_ ` _ \| |'
echo $'  / ____ \\__ \ |_| | | | | | | |'
echo $' /_/    \_\___/\__,_|_| |_| |_|_|'
echo $'STOCK'
echo $''

make clean 


export KBUILD_BUILD_USER=ekkusa
export KBUILD_BUILD_HOST=azure 
export DEVICE_DEFCONFIG=tama_akari_kddi_defconfig


echo $'"           asumi compiler            "'
echo $'-------------------------------------'
echo BUILDER NAME = ${KBUILD_BUILD_USER}
echo BUILDER HOSTNAME = ${KBUILD_BUILD_HOST}
echo DEVICE_DEFCONFIG = ${DEVICE_DEFCONFIG}
echo $'-------------------------------------'
echo $''

echo $''
echo "Compiling Kernel.."
echo $''

args="-j$(nproc --all) \
	O=out \
	ARCH=arm64 \
	CLANG_TRIPLE=aarch64-linux-gnu- \
	CROSS_COMPILE=/home/azureuser/androids/exer/experimental/proton-clang/bin/aarch64-linux-gnu- \
	CC=/home/azureuser/androids/exer/experimental/proton-clang/bin/clang \
	CROSS_COMPILE_ARM32=/home/azureuser/androids/exer/experimental/proton-clang/bin/arm-linux-gnueabi- "
	make ${args} ${DEVICE_DEFCONFIG}
	make ${args}

echo $''
echo "Asumi Kernel has been compiled successfully! "
echo $''

echo $''
echo "Cloning anykernel"
echo $''

rm -rf anykernel3
rm /home/azureuser/androids/exer/kernel/stocksumi.zip

git clone https://github.com/ekkusa/AnyKernel3 anykernel3

echo $''
echo "Packing Kernel"
echo $''

rm -rf anykernel3/Image.gz-dtb
cp out/arch/arm64/boot/Image.gz-dtb anykernel3
cd anykernel3
rm -rf stocksumi.zip
zip -q -r stocksumi.zip *

echo $''
echo "Packing done!"
echo $''

cp stocksumi.zip /home/azureuser/androids/exer/kernel/
cd /home/azureuser
./gdrive upload /home/azureuser/androids/exer/kernel/stocksumi.zip

echo $''
echo "Uploaded to Gdrive"
echo $''

echo $''
echo $'     /\                       (_)'
echo $'    /  \   ___ _   _ _ __ ___  _ '
echo $'   / /\ \ / __| | | | `_ ` _ \| |'
echo $'  / ____ \\__ \ |_| | | | | | | |'
echo $' /_/    \_\___/\__,_|_| |_| |_|_|'
echo $''

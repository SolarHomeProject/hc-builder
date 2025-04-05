#!/bin/bash -e

ROOT_PATH=$(pwd)

function apply_fixes() {
cp -r $ROOT_PATH/fixes/* $ROOT_PATH/tmp/
}

if [ -d "tmp" ]; then
    rm -rf tmp output
fi

mkdir tmp && cd tmp

for repo in HomeControl hc-web hc-deb hc-gen
do
    git clone https://github.com/SolarHomeProject/$repo.git
done

echo "Building webapp..."

cd hc-web
npm install
apply_fixes
grunt

echo "Copying compiled webfiles..."

cd dist
for file in css/* js/*; do
    cp $file ../../HomeControl/web/sfile/
done

for file in html/*; do
    cp $file ../../HomeControl/web/static/
done
cd ../..

echo "Building Debian Package..."

cd hc-deb
cp -r ../HomeControl opt/
dpkg-buildpackage -uc -us -b
cd ..

echo "Building final .img card image..."

cp homecontrol*.deb hc-gen/stage3/00-hc/files
cd hc-gen
./build.sh
cd ..

echo "Copying output file..."

mkdir ../output
mv hc-gen/deploy/* ../output/
rm -rf tmp

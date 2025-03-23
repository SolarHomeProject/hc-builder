#!/bin/bash -e

if [ -d "tmp" ]; then
    rm -rf tmp output
fi

mkdir tmp && cd tmp

for repo in HomeControl hc-web hc-deb hc-gen
do
    git clone https://github.com/SolarHomeProject/$repo.git
done

echo "Building webapp..."

cd hc-webapp
grunt
cd ..

echo "Copying compiled webfiles..."

cp -r HomeControl hc-deb/opt/
cd hc-webapp/dist
for file in css/* js/*; do
    cp $file ../../hc-deb/opt/HomeControl/web/sfile/
done

for file in html/*; do
    cp $file ../../hc-deb/opt/HomeControl/web/static/
done
cd ../..

echo "Building Debian Package..."

cd hc-deb
dpkg-buildpackage -uc -us -b
cd ..

echo "Building final .img card image..."

cp homecontrol*.deb pi-gen/stage3/00-hc/files
cd pi-gen
./build.sh
cd ..

echo "Copying output file..."

mkdir ../output
mv pi-gen/deploy/* ../output/
rm -rf tmp

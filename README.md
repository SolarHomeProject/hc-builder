# hc-builder
Builds HomeControl

## Build dependencies

### hc-gen
```bash
apt install coreutils quilt parted qemu-user-static debootstrap zerofree zip \
dosfstools libarchive-tools libcap2-bin grep rsync xz-utils file git curl bc \
gpg pigz xxd arch-test bmap-tools
```
https://github.com/RPi-Distro/pi-gen/blob/master/README.md

### hc-web
```bash
curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh
bash nodesource_setup.sh
apt install -y nodejs
```
https://github.com/nodesource/distributions?tab=readme-ov-file#using-debian-as-root-nodejs-23

### hc-deb
```bash
apt install dpkg-dev
```

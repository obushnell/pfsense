#!/bin/sh

pkg install -y nano

# Required for installing and building ports
pkg install -y nginx poudriere-devel rsync

# Required for building kernel and iso
pkg install -y vmdktool curl qemu-user-static gtar xmlstarlet pkgconf openssl

# Required for building iso
portsnap fetch extract

# not required but advised for building/monitoring/debugging
pkg install -y htop screen wget mmv

# Only install this if your FreeBSD is a virtual machine
pkg install -y open-vm-tools

# Usefull stuff
pkg install -y pkg-provides
sed -i -p0e 's$#PKG_PLUGINS_DIR.*?PLUGINS [\n]$PKG_PLUGINS_DIR = "/usr/local/lib/pkg/";\nPKG_ENABLE_PLUGINS = true;\nPLUGINS [\n        provides\n]$se' /usr/local/etc/pkg.conf

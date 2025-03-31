#!/usr/bin/env bash

set -euox pipefail

# See https://github.com/centos-workstation/achillobator/issues/3
mkdir -m 0700 -p /var/roothome
# Fast track https://gitlab.com/fedora/bootc/base-images/-/merge_requests/71
ln -sf /run /var/run

dnf config-manager --set-enabled extras-common
dnf config-manager --set-enabled baseos
dnf config-manager --set-enabled appstream

#dnf config-manager --set-enabled crb
#dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

# add some packages present in Fedora CoreOS but not Stream CoreOS
dnf -y install --setopt=install_weak_deps=False \
  clevis-pin-tpm2 \
  nfs-utils-coreos \
  wireguard-tools

# remove some packages present in CentOS bootc but not Fedora CoreOS
dnf -y remove \
  gssproxy \
  nfs-utils \
  quota \
  quota-nls

# required for bootc container lint; copied from centos-bootc image
cat << EOF > /usr/lib/ostree/prepare-root.conf
[composefs]
enabled = yes
[sysroot]
readonly = true
EOF

!/usr/bin/env bash

set -euox pipefail

# See https://github.com/centos-workstation/achillobator/issues/3
mkdir -m 0700 -p /var/roothome
# Fast track https://gitlab.com/fedora/bootc/base-images/-/merge_requests/71
ln -sf /run /var/run

#dnf config-manager --set-enabled crb
#dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

# add some packages present in Fedora CoreOS but not CentOS bootc
dnf -y install --setopt=install_weak_deps=False \
  NetworkManager-team \
  afterburn \
  afterburn-dracut \
  audit \
  authselect \
  clevis-dracut \
  clevis-pin-tpm2 \
  coreos-installer \
  coreos-installer-bootinfra \
  git-core \
  hwdata \
  ignition \
  ipcalc \
  iscsi-initiator-utils \
  nfs-utils-coreos \
  runc \
  rsync \
  ssh-key-dir \
  wireguard-tools

# remove some packages present in CentOS bootc but not Fedora CoreOS
dnf -y remove \
  gssproxy \
  nfs-utils \
  quota \
  quota-nls

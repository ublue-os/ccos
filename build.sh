#!/usr/bin/env bash

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
  firewalld \
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

# apply CoreOS overlays
cd /tmp/
git clone https://github.com/coreos/fedora-coreos-config
cd fedora-coreos-config
git checkout stable
cd overlay.d
# remove overlays which should not be used on CentOS
# no composefs by default on CentoOS stream9
rm -fr 08composefs
# remove fedora specific stuff
rm -fr 15fcos/usr/lib/dracut
rm -fr 15fcos/usr/lib/motd.d
rm -fr 15fcos/usr/lib/systemd
rm -fr 15fcos/usr/libexec
# zincati should not even exist in a bootc image
rm -fr 16disable-zincati
# now try to apply
for od in $(find * -maxdepth 0 -type d); do
  pushd ${od}
  find * -maxdepth 0 -type d -exec rsync -av ./{}/ /{}/ \;
  if [ -f statoverride ]; then
    for line in $(grep ^= statoverride|sed 's/ /=/'); do
      DEC=$(echo $line|cut -f2 -d=)
      OCT=$(printf %o ${DEC})
      FILE=$(echo $line|cut -f3 -d=)
      chmod ${OCT} ${FILE}
    done
  fi
  popd
done

# enable systemd-resolved for proper name resolution
systemctl enable systemd-resolved.service

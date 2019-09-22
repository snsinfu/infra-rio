#!/bin/sh -eu

sign_key="/root/mok-privkey.pem"
sign_cert="/root/mok-cert.pem"

kernel="$(uname -r)"
arch="$(uname -m)"

pwd
cd "../${kernel}/${arch}/module"

for kmod in *.ko; do
  echo "Signing ${kmod}"
  /usr/src/linux-headers-${kernel}/scripts/sign-file \
    sha256                                              \
    "${sign_key}"                                       \
    "${sign_cert}"                                      \
    "${kmod}"
done

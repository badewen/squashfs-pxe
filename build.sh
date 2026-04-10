# ── initrd ───────────────────────────────────────────────────────────────────
echo "==> Cleaning initrd..."
(
  cd initrd-final
  sudo find . -type l -exec unlink {} \;
  sudo rm -r *
)

set -euo pipefail

# ── iPXE ────────────────────────────────────────────────────────────────────
echo "==> Building iPXE..."
(
  cd ./ipxe/src
  make bin-x86_64-pcbios/ipxe--intel.pxe \
    EMBED="$(pwd)/../../embed.ipxe" \
    -j$(nproc)
  cp bin-x86_64-pcbios/ipxe--intel.pxe ../../tftp/ipxe.pxe
)


echo "==> Extracting packages and setup busybox..."
(
  cd initrd-final
  for pkg in ../packages/*.apk; do
    echo "  -> Extracting $(basename "$pkg")..."
    sudo tar -xzf "$pkg"
  done
  sudo cp -ra ../initrd/* .
  sudo chroot . /bin/busybox --install -s
)

echo "==> Building initrd..."
(
  cd initrd-final
  sudo find | sudo cpio -o -H newc | gzip > ../initrd.gz
  sudo cp ../initrd.gz ../http/
)

# ── Kernel ───────────────────────────────────────────────────────────────────
echo "==> Building kernel..."
(
  cd kernel
  make all -j$(nproc)
  cp arch/x86/boot/bzImage ../http/vmlinuz
)

# ── Config ───────────────────────────────────────────────────────────────────
echo "==> Copying autoexec.ipxe..."
sudo cp ./autoexec.ipxe ./http/

echo "==> Done."

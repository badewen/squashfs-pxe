# ── Host dependencies ────────────────────────────────────────────────────────
echo "==> Installing build dependencies..."
apk add git sudo gcc make bc binutils perl xz-dev mtools coreutils autoconf bash \
    flex bison pahole util-linux kmod dwarf-tools openssl \
    openssl-dev tar python3 \
    elfutils-dev linux-headers \
# adding linux-headers is kinda a "nasty hack" since the added version may not be the same

# ── Linux kernel ─────────────────────────────────────────────────────────────
echo "==> Cloning Linux kernel (v6.19.11)..."
git clone --branch=v6.19.11 --depth=1 \
  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git \
  kernel
cp .config kernel/

# ── initrd packages ──────────────────────────────────────────────────────────
echo "==> Fetching initrd packages..."
./fetch_apk.sh $(cat packages.list)

# ── iPXE ─────────────────────────────────────────────────────────────────────
echo "==> Cloning iPXE..."
git clone --depth=1 https://github.com/ipxe/ipxe.git

echo "==> Done."

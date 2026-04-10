# Requirement
- Alpine linux
- Enough ram and storage to compile linux kernel

# Usage
1. run `./prepare.sh` only once, to prepare the source for compiling
2. run `./build.sh` to build things.
3. point your web server to the http folder and tftp server to the tftp folder
## Note: The squashfs filesystem must be named `filesytem.squashfs` and placed in the `http` folder 

# `tftp` folder
`ipxe.efi` & `ipxe-shim.efi` are from v2.0.0 [releases](https://github.com/ipxe/ipxe/releases/tag/v2.0.0), signed by the iPXE team for secure boot. Therefore you dont need to worry about me tampering these files. For non UEFI boot, it will build from source.

# `initrd` folder
This folder is used to overlay on top of all of the extracted packages.

# `http` and `tftp` folder
These folders are used for output. point your web serverr to the http folder

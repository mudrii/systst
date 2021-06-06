# Install NIxOS from flakes

# NixOs LUKS PV Home Manager Flake deployment

## Prep Disk

```sh
lsblk

wipefs -a /dev/vda
```

## Diff install Optional

```sh
export ROOT_DISK=/dev/vda

# Create boot partition first
parted -a opt --script "${ROOT_DISK}" \
    mklabel gpt \
    mkpart primary fat32 0% 512MiB \
    mkpart primary 512MiB 100% \
    set 1 esp on \
    name 1 boot \
    set 2 lvm on \
    name 2 root

fdisk /dev/vda -l
```

## Encrypt Primary Disk

```sh
cryptsetup luksFormat /dev/disk/by-partlabel/root

cryptsetup luksOpen /dev/disk/by-partlabel/root root

pvcreate /dev/mapper/root

vgcreate vg /dev/mapper/root

lvcreate -L 4G -n swap vg

lvcreate -l '100%FREE' -n root vg

lvdisplay
```

## Format Disks

```sh
mkfs.fat -F 32 -n boot /dev/disk/by-partlabel/boot

mkfs.ext4 -L root /dev/vg/root

mkswap -L swap /dev/vg/swap

swapon -s
```

## Mount

```sh
mount /dev/disk/by-label/root /mnt

mkdir -p /mnt/boot

mount /dev/disk/by-label/boot /mnt/boot

swapon /dev/vg/swap
```

## Install system

```sh
nix-shell -p git nixFlakes

git clone https://github.com/mudrii/systst.git /mnt/etc/nixos

nixos-install --root /mnt --flake /mnt/etc/nixos#nixtst

reboot

sudo nix flake update /etc/nixos/

sudo nixos-rebuild switch --flake /etc/nixos/#nixtst
```

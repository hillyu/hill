#!/usr/bin/env bash

qemu-system-x86_64 -enable-kvm -machine q35 -device intel-iommu -vga virtio -display sdl,gl=on \
                   -usb -device usb-tablet \
                   -device virtio-mouse-pci -device virtio-keyboard-pci \
                   -m 2048 -smp 2 -cpu host \
                   -soundhw ac97 \
                   -net nic,model=e1000 -net user \
                   -monitor stdio vms/android.img

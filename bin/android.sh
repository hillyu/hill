#!/usr/bin/env bash

qemu-system-x86_64 -enable-kvm -machine q35 -vga virtio -display gtk,gl=on \
                   -usb -device usb-tablet \
                   -m 8G -smp 4 -cpu host \
                   -soundhw ac97 \
                   -net nic,model=e1000 -net user \
                   -monitor stdio vms/android.img
                   # -device virtio-mouse-pci -device virtio-keyboard-pci -device intel\

#!/usr/bin/env bash

qemu-system-x86_64 -enable-kvm -machine q35 \
                   -device virtio-vga-gl \
                   -display gtk,gl=on \
                   -usb -device usb-tablet \
                   -m 8G -smp 4 -cpu host \
                   -device AC97 \
                   -net nic,model=e1000 -net user \
                   -monitor stdio \
                   -hda vms/android2.img 
                   # -device virtio-mouse-pci -device virtio-keyboard-pci -device intel\

# qemu-system-x86_64 \
#      -enable-kvm \
#      -device virtio-vga-gl \
#      -display gtk,gl=on \
#      -m 8G \
#      -smp 4 \
#      -cpu host \
#      -device es1370 \
#      -usb \
#      -device usb-tablet \
#      -boot menu=on \
#      -net nic \
#      -net user,hostfwd=tcp::5555-:22 \
#      -hda vms/android.img


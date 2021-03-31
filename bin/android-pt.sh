#!/usr/bin/env bash

GPU="0000:03:00.0"
GPU_AUDIO="0000:03:00.6"

# echo "$GPU" > /sys/bus/pci/drivers/amdgpu/unbind
# echo "$GPU_AUDIO" > /sys/bus/pci/drivers/snd_hda_intel/unbind

# echo vfio-pci > /sys/bus/pci/devices/$GPU/driver_override
# echo vfio-pci > /sys/bus/pci/devices/$GPU_AUDIO/driver_override
# modprobe vfio-pci

# qemu-system-x86_64 \
#       -enable-kvm \
#       -smp 4 \
#       -m 8G \
#       -nographic \
#       -vga none \
#       -device vfio-pci,host=$GPU,x-vga=on \
#
qemu-system-x86_64  -enable-kvm \
  -smp 4 \
  -m 8G \
  -machine q35 \
  -drive if=pflash,format=raw,readonly,file=/usr/share/edk2-ovmf/x64/OVMF_CODE.fd \
  -drive if=pflash,format=raw,file=/usr/share/edk2-ovmf/x64/OVMF_VARS.fd \
  -nographic \
  -vga none \
  -device vfio-pci,host=$GPU \
  -device vfio-pci,host=$GPU_AUDIO vms/android.img

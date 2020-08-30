efibootmgr -b 1 -B
efibootmgr -b 2 -B
efibootmgr -b 3 -B
efibootmgr -b 4 -B
#efibootmgr --disk /dev/nvme0n1 --part 1 --create --label "Arch Linux-ck-zen(fallback)" --loader /ArchLinux/vmlinuz-linux-ck-zen --unicode 'root=UUID=7c782947-af58-4f63-8732-c769c8a7c281 initrd=\ArchLinux\amd-ucode.img initrd=\ArchLinux\initramfs-linux-ck-zen-fallback.img rw quiet' --verbose
#efibootmgr --disk /dev/nvme0n1 --part 1 --create --label "Arch Linux-ck-zen" --loader /ArchLinux/vmlinuz-linux-ck-zen --unicode 'root=UUID=7c782947-af58-4f63-8732-c769c8a7c281 initrd=\ArchLinux\amd-ucode.img initrd=\ArchLinux\initramfs-linux-ck-zen.img rw quiet loglevel=3 rd.systemd.show_status=auto rd.udev.log_priority=3 mitigations=off amd_iommu=on iommu=pt' --verbose
efibootmgr --disk /dev/nvme0n1 --part 1 --create --label "Arch Linux-zen(fallback)" --loader /ArchLinux/vmlinuz-linux-zen --unicode 'root=UUID=7c782947-af58-4f63-8732-c769c8a7c281 initrd=\ArchLinux\amd-ucode.img initrd=\ArchLinux\initramfs-linux-zen-fallback.img rw quiet' --verbose
efibootmgr --disk /dev/nvme0n1 --part 1 --create --label "Arch Linux-zen" --loader /ArchLinux/vmlinuz-linux-zen --unicode 'root=UUID=7c782947-af58-4f63-8732-c769c8a7c281 initrd=\ArchLinux\amd-ucode.img initrd=\ArchLinux\initramfs-linux-zen.img rw quiet loglevel=3 rd.systemd.show_status=auto rd.udev.log_priority=3 mitigations=off iommu=pt audit=0' --verbose
efibootmgr --disk /dev/nvme0n1 --part 1 --create --label "Arch Linux(fallback)" --loader /ArchLinux/vmlinuz-linux --unicode 'root=UUID=7c782947-af58-4f63-8732-c769c8a7c281 initrd=\ArchLinux\amd-ucode.img initrd=\ArchLinux\initramfs-linux-fallback.img rw quiet break=postmount' --verbose
efibootmgr --disk /dev/nvme0n1 --part 1 --create --label "Arch Linux" --loader /ArchLinux/vmlinuz-linux --unicode 'root=UUID=7c782947-af58-4f63-8732-c769c8a7c281 initrd=\ArchLinux\amd-ucode.img initrd=\ArchLinux\initramfs-linux.img rw quiet nosplash rd.systemd.show_status=auto rd.udev.log_priority=3 loglevel=3 mitigations=off acpi_backlight=video ipv6.disable=1 random.trust_cpu=on'  --verbose

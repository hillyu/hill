echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=zh_CN.UTF-8" > /etc/locale.conf
echo "#LANG=en_US.UTF-8" >> /etc/locale.conf
rm /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

wget -O- https://deepin-wine.i-m.dev/setup.sh | sh
sudo apt-get install com.qq.weixin.deepin
sudo rm /etc/apt/sources.list.d/deepin-wine.i-m.dev.list
env WINEPREFIX="$HOME/.deepinwine/Deepin-WeChat" deepin-wine6-stable winecfg
echo 'Please reboot'

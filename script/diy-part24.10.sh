#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

status_cfg=$(git status | grep -cE "feeds.conf.default$")
if [[ $status_cfg -eq 1 ]]; then
    git reset HEAD feeds.conf.default
    git checkout feeds.conf.default
fi

\rm -rf ./tmp
\rm -rf ./logs/*

git pull

# Add a feed source
echo "src-git feeds_app https://github.com/kenzok8/openwrt-packages" >> feeds.conf.default
echo "src-git small https://github.com/kenzok8/small" >> feeds.conf.default
echo 'src-git qmodem https://github.com/FUjr/QModem.git;main' >> feeds.conf.default
#echo 'src-git mt5700webui https://gitee.com/kcro/luci-app-mt5700webui.git;master' >> feeds.conf.default
./scripts/feeds update -a && rm -rf feeds/luci/{luci-app-airwhu}
rm -rf feeds/small/{luci-app-fchomo,luci-app-bypass,luci-app-nikki,luci-app-passwall2,mihomo,nikki,luci-app-homeproxy}
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
./scripts/feeds install -a

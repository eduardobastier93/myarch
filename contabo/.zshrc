#!/bin/bash
# github.com/mamutal91
# https://www.youtube.com/channel/UCbTjvrgkddVv4iwC9P2jZFw

# Themes https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

export ZSH="/home/mamutal91/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export TERM="xterm-256color"
export EDITOR="nano"
export BROWSER="/usr/bin/google-chrome-stable"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"

export IDIOMA="en_US.UTF-8"
export LANGUAGE=$IDIOMA
export LC_ALL=$IDIOMA
export LC_CTYPE=$IDIOMA
export LANG=$IDIOMA

export PATH=$HOME/.bin:$PATH
export USE_CCACHE=1
export CCACHE_DIR="$HOME/.ccache"
export CCACHE_EXEC="$(which ccache)"

export SELINUX_IGNORE_NEVERALLOWS=true
export CUSTOM_BUILD_TYPE=OFFICIAL
export OPENGAPPS_TYPE=ALPHA

export aosp=$HOME/aosp
export branch="ten"
export los="lineage-17.1"

alias bp="cd $HOME/aosp && repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags --force-sync && opengapps && . build/envsetup.sh && lunch aosp_beryllium-userdebug && make -j$(nproc --all) bacon 2>&1 | tee log.txt"
alias b="cd $HOME/aosp && . build/envsetup.sh && lunch aosp_beryllium-userdebug && make -j$(nproc --all) bacon 2>&1 | tee log.txt"

function nginx () {
  sudo systemctl enable nginx
  sudo systemctl start nginx
}


function push () {
  git push ssh://git@github.com/mamutal91/${1} HEAD:refs/heads/${2} --force
  git push ssh://git@github.com/aosp-forking/${1} HEAD:refs/heads/${2} --force
}

function tree () {
  cd $aosp
  rm -rf device/xiaomi/beryllium
  rm -rf device/xiaomi/sdm845-common
  git clone ssh://git@github.com/mamutal91/device_xiaomi_beryllium -b $branch device/xiaomi/beryllium
  git clone ssh://git@github.com/mamutal91/device_xiaomi_sdm845-common -b $branch device/xiaomi/sdm845-common
}

function tree_pull () {
  pwd_tree_pull=$(pwd)
  cd $HOME/.pull_rebase
  rm -rf device_xiaomi_beryllium device_xiaomi_sdm845-common

  git clone ssh://git@github.com/mamutal91/device_xiaomi_beryllium -b $branch
  cd device_xiaomi_beryllium
  git pull --rebase https://github.com/AOSiP-Devices/device_xiaomi_beryllium -t ten && git rebase
  echo && echo "Pushing......................." && echo && git push && echo && echo && cd ..

  git clone ssh://git@github.com/mamutal91/device_xiaomi_sdm845-common -b $branch
  cd device_xiaomi_sdm845-common
  git pull --rebase https://github.com/AOSiP-Devices/device_xiaomi_sdm845-common -t ten && git rebase
  echo && echo "Pushing......................." && echo && git push && echo && echo && cd ..

  rm -rf device_xiaomi_beryllium device_xiaomi_sdm845-common
  cd $pwd_tree_pull
}

function tree_kernel () {
  cd $aosp
  rm -rf kernel/xiaomi
  git clone https://github.com/AOSiP-Devices/kernel_xiaomi_sdm845 -b ten kernel/xiaomi/sdm845
}

function tree_vendor () {
  pwd_tree_vendor=$(pwd)
  cd $aosp
  rm -rf vendor/xiaomi
  git clone https://github.com/AOSiP-Devices/proprietary_vendor_xiaomi -b ten vendor/xiaomi
  cd vendor/xiaomi
  rm -rf dipper jasmine_sprout mido msm8953-common platina raphael sdm660-common wayne wayne-common whyred
  cd $pwd_tree_vendor
}

function opengapps () {
  pwd_opengapps=$(pwd)
  cd $aosp/vendor/opengapps/build && git lfs fetch --all && git lfs pull
  cd $aosp/vendor/opengapps/sources/all && git lfs fetch --all && git lfs pull
  cd $aosp/vendor/opengapps/sources/arm && git lfs fetch --all && git lfs pull
  cd $aosp/vendor/opengapps/sources/arm64 && git lfs fetch --all && git lfs pull
  cd $aosp/vendor/opengapps/sources/x86 && git lfs fetch --all && git lfs pull
  cd $aosp/vendor/opengapps/sources/x86_64 && git lfs fetch --all && git lfs pull
  cd $pwd_opengapps
}

function scripts () {
  pwd_scripts=$(pwd)
  rm -rf $HOME/.zshrc && cd $HOME && wget https://raw.githubusercontent.com/mamutal91/archlinux/master/contabo/.zshrc && source $HOME/.zshrc
  rm -rf $HOME/.update.sh && wget https://raw.githubusercontent.com/mamutal91/archlinux/master/contabo/update.sh && mv update.sh .update.sh && chmod +x .update.sh
  rm -rf $HOME/.setup.sh && wget https://raw.githubusercontent.com/mamutal91/archlinux/master/contabo/setup.sh && mv setup.sh .setup.sh && chmod +x .setup.sh
  rm -rf $HOME/.mysetup.sh && wget https://raw.githubusercontent.com/mamutal91/archlinux/master/contabo/mysetup.sh && mv mysetup.sh .mysetup.sh && chmod +x .mysetup.sh
  clear
  cd $pwd_scripts
}

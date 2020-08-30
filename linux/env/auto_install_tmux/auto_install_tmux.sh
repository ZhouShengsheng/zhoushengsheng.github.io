#!/usr/bin/env bash
# Automatically install tmux under current user.
# Author: Zhou Shengsheng
# Date: 30/08/2020

# Configs
BASE_DIR=${HOME}
SRC_DIR=${BASE_DIR}/3rd/src
LOCAL_DIR=${BASE_DIR}/local
BASH_PROFILE=${HOME}/.bash_profile
TMUX_BUNDLE_URL=https://raw.githubusercontent.com/ZhouShengsheng/zhoushengsheng.github.io/master/linux/env/auto_install_tmux/tmux_bundle.tar.gz

# Get count of cpu
declare -i cpus
if ! command -v nproc &> /dev/null
then
  echo "nproc command not found, set cpu count to 8 for compiling"
  cpus=8
else
  cpus=$(nproc)
fi

# Setup
echo "Setup, SRC_DIR=${SRC_DIR}, LOCAL_DIR=${LOCAL_DIR}"
mkdir -p ${SRC_DIR}
mkdir -p ${LOCAL_DIR}
cat <<EOT >> ${BASH_PROFILE}
export CPATH=${LOCAL_DIR}/include:${CPATH}
export LIBRARY_PATH=${LOCAL_DIR}/lib:${LIBRARY_PATH}
export PATH=${LOCAL_DIR}/bin:${PATH}
export LD_LIBRARY_PATH=${LOCAL_DIR}/lib:${LD_LIBRARY_PATH}
EOT
source ${BASH_PROFILE}

# Install tmux and its dependencies

cd ${SRC_DIR}

echo "Download tmux bundle"
wget ${TMUX_BUNDLE_URL}
tar -xf tmux_bundle.tar.gz
cd tmux_bundle

echo "Install dependencies[ncurses,libevent]"
# Install ncurses
cd ${SRC_DIR}/tmux_bundle/src/ncurses-6.1
./configure --prefix=${LOCAL_DIR}
make -j ${cpus}
make install
# Install libevent
cd ${SRC_DIR}/tmux_bundle/src/libevent-2.1.8-stable
./configure --prefix=${LOCAL_DIR}
make -j ${cpus}
make install

echo "Install tmux"
cd ${SRC_DIR}/tmux_bundle/src/tmux-2.8
./configure --prefix=${LOCAL_DIR}
make -j ${cpus}
make install

echo "Config tmux"
cd ${SRC_DIR}/tmux_bundle
cp -r tpm tmux.conf ${BASE_DIR}

echo "Done! Please source ${BASH_PROFILE} manually by running following command:
source ${BASH_PROFILE}"

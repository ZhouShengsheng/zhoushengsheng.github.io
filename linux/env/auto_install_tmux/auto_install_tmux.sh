#!/usr/bin/env bash
# Automatically install tmux under current user.
# Author: Zhou Shengsheng
# Date: 30/08/2020

# Configs
BASE_DIR=${HOME}
LOCAL_DIR=${BASE_DIR}/local
BASH_PROFILE=${HOME}/.bash_profile
TMUX_BUNDLE_URL=https://raw.githubusercontent.com/ZhouShengsheng/zhoushengsheng.github.io/master/linux/env/auto_install_tmux/tmux_bundle.tar.gz
TMUX_INSTALL_LOG=${BASE_DIR}/tmux_install.log

# Log function
function logInfo() {
  msg=$1
  echo -e ">>> ${msg}" | tee -a ${TMUX_INSTALL_LOG}
}

# Install function
function install() {
  CFLAGS="$CFLAGS -I${LOCAL_DIR}/include/ncurses" ./configure --prefix=${LOCAL_DIR} >> ${TMUX_INSTALL_LOG}
  make -j ${cpus} >> ${TMUX_INSTALL_LOG}
  make install >> ${TMUX_INSTALL_LOG}
  echo >> ${TMUX_INSTALL_LOG}
}

# Get count of cpu
declare -i cpus
if ! command -v nproc &> /dev/null
then
  logInfo "nproc command not found, set cpu count to 8 for compiling"
  cpus=8
else
  cpus=$(nproc)
fi

# Setup
logInfo "Setup, BASE_DIR=${BASE_DIR}, LOCAL_DIR=${LOCAL_DIR}"
mkdir -p ${BASE_DIR}
mkdir -p ${LOCAL_DIR}
cat <<EOT >> ${BASH_PROFILE}
export CPATH=${LOCAL_DIR}/include:\${CPATH}
export LIBRARY_PATH=${LOCAL_DIR}/lib:\${LIBRARY_PATH}
export PATH=${LOCAL_DIR}/bin:\${PATH}
export LD_LIBRARY_PATH=${LOCAL_DIR}/lib:\${LD_LIBRARY_PATH}
EOT

export CPATH=${LOCAL_DIR}/include:${CPATH}
export LIBRARY_PATH=${LOCAL_DIR}/lib:${LIBRARY_PATH}
export PATH=${LOCAL_DIR}/bin:${PATH}
export LD_LIBRARY_PATH=${LOCAL_DIR}/lib:${LD_LIBRARY_PATH}

# Install tmux and its dependencies

cd ${BASE_DIR}

logInfo "Download tmux bundle"
wget ${TMUX_BUNDLE_URL}
tar -xf tmux_bundle.tar.gz
cd tmux_bundle

logInfo "Install dependencies[ncurses,libevent]"
# Install ncurses
cd ${BASE_DIR}/tmux_bundle/src/ncurses-6.1
install
# Install libevent
cd ${BASE_DIR}/tmux_bundle/src/libevent-2.1.8-stable
install

logInfo "Install tmux"
cd ${BASE_DIR}/tmux_bundle/src/tmux-2.8
install

logInfo "Config tmux"
cd ${BASE_DIR}/tmux_bundle
cp .tmux.conf ${BASE_DIR}
mkdir -p ${BASE_DIR}/.tmux/plugins
cp -r tpm ${BASE_DIR}/.tmux/plugins
chmod +x ${BASE_DIR}/.tmux/plugins/tpm/scripts/install_plugins.sh
${BASE_DIR}/.tmux/plugins/tpm/scripts/install_plugins.sh >> ${TMUX_INSTALL_LOG}

logInfo "Clean up"
cd ${BASE_DIR}
rm -rf tmux_bundle* ${TMUX_INSTALL_LOG}

logInfo "Done! Please source ${BASH_PROFILE} manually by running following command:\nsource ${BASH_PROFILE}"

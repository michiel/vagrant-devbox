#!/bin/bash -eux

update_package_index() {
    sudo apt-get update
}

install_required_packages() {
  sudo apt-get install -y \
    aptitude \
    locales \
    zsh \
    vim \
    tmux \
    curl \
    cmake \
    golang-go \
    valgrind \
    git \
    tig \
    tree \
    zip \
    unzip \
    htop \
    whois \
    stow \
    ack-grep \
    dos2unix \
    build-essential \
    python3-dev \
    libxml2-dev \
    libyaml-dev \
    libxslt1-dev \
    libffi-dev \
    libfreetype6-dev \
    libimage-exiftool-perl \
    libjpeg-dev \
    xclip \
    libreadline-dev \
    openjdk-8-jdk-headless \
    maven \
    silversearcher-ag
#     pandoc \
#     texlive-latex-base \
#     texlive-xetex \
#     texlive-fonts-recommended-doc
}

install_googletests() {
    sudo apt-get install g++ libgtest-dev
    cd /usr/src/gtest
    sudo cmake .
    sudo make
    sudo cp libg* /usr/lib/
}

setup_zsh() {
  chsh -s /bin/zsh vagrant
  if [[ ! -d "/home/vagrant/.oh-my-zsh" ]]; then
    run_as_vagrant "git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh"
  fi
  run_as_vagrant "cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc"
}

setup_gdb() {
  run_as_vagrant "cd; curl -o ~/.gdbinit https://raw.githubusercontent.com/cyrus-and/gdb-dashboard/master/.gdbinit"
}

setup_tmux() {
  if [[ ! -d "/home/vagrant/.tmux" ]]; then
    run_as_vagrant "git clone https://github.com/gpakosz/.tmux.git ~/.tmux"
  fi
  run_as_vagrant "cd; ln -s -f ~/.tmux/.tmux.conf"
  run_as_vagrant "cp .tmux/.tmux.conf.local ~/.tmux.conf.local"
}

setup_locale() {
  echo "Melbourne/Australia" > /etc/timezone
  dpkg-reconfigure -f noninteractive tzdata
	# LANG=en_GB.UTF-8
	# sed -i -e "s/# $LANG.*/$LANG.UTF-8 UTF-8/" /etc/locale.gen
	# dpkg-reconfigure --frontend=noninteractive locales
	# update-locale LANG=$LANG
}

install_rust() {
    run_as_vagrant "curl https://sh.rustup.rs -sSf | sh -s -- -y"
    run_as_vagrant "rustup component add rust-src"
}

install_latest_node_v7() {
    curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
    sudo apt-get install -y nodejs
}

install_global_npm_packages() {
    npm install --global eslint
}

install_ruby_rbenv() {
    RBENV_DIR=/home/vagrant/.rbenv

    if [ -d "${RBENV_DIR}" ]; then
        cd "${RBENV_DIR}"
        git pull
        cd -
    else
        git clone https://github.com/rbenv/rbenv.git "${RBENV_DIR}"
    fi

    chown -R vagrant "${RBENV_DIR}"
}

install_ruby_2_3_3() {
    run_as_vagrant "rbenv install 2.3.3"
}

install_ruby_2_4_1() {
    run_as_vagrant "rbenv install 2.4.1"
}

run_as_vagrant() {
  su vagrant bash -l -c "$1"
}

update_package_index
install_required_packages
# setup_zsh
setup_gdb
setup_tmux
setup_locale
install_googletests
install_latest_node_v7
install_global_npm_packages
# install_rust
# install_ruby_rbenv
# install_ruby_2_4_1


#!/bin/bash -eux

install_extra_ppas() {
    # add heroku repository to apt
    echo "deb http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
    # install heroku's release key for package verification
    wget -q -O- https://toolbelt.heroku.com/apt/release.key | apt-key add -
}

update_package_index() {
    sudo apt-get update
}

install_required_packages() {
  sudo apt-get install -y \
    aptitude \
    git \
    tig \
    tree \
    zip \
    unzip \
    htop \
    whois \
    ack-grep \
    dos2unix \
    build-essential \
    libpq-dev \
    python-dev \
    python3-dev \
    libxml2-dev \
    libyaml-dev \
    libxslt1-dev \
    libffi-dev \
    libfreetype6-dev \
    libimage-exiftool-perl \
    libjpeg-dev \
    xclip \
    gnupg-curl \
    libreadline-dev \
    openjdk-8-jre-headless \
    openjdk-8-jdk-headless \
    silversearcher-ag \
    pandoc \
    texlive-latex-base \
    texlive-xetex \
    texlive-fonts-recommended-doc
}

install_rust() {
    curl https://sh.rustup.rs -sSf | sh
    rustup completions bash > /etc/bash_completion.d/rustup.bash-completion
    rustup completions zsh > ~/.zfunc/_rustup
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
install_latest_node_v7
install_global_npm_packages
install_rust


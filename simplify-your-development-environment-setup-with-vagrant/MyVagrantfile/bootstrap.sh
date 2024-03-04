#!/usr/bin/env bash

l0g() {
    local b="\e[1m"
    local bn="\e[21m"
    local lc="\e[96m"
    local lcn="\e[0m"
    echo -e "$b${lc[+]} $1$bn$lcn"
    sleep 2
}

apt_install() {
    DEBIAN_FRONTEND=noninteractive apt-get install -qq -y "$1" >/dev/null
    l0g "$1 Installed"
}

install_zsh() {
    ## install zsh as shell then install oh-my-zsh
    apt_install "zsh"
    su -l vagrant -s "/bin/sh" \
        -c "curl -fsSO https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh; chmod 755 install.sh; ./install.sh --unattended"
    su -l vagrant -s "/bin/sh" -c "sed -i 's/=\"robbyrussell\"/=\"pygmalion\"/g' ~/.zshrc"
    su -l vagrant -s "/bin/sh" -c "rm install.sh"
    chsh -s /bin/zsh vagrant

    # install plugins
    su -l vagrant -s "/bin/sh" -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    su -l vagrant -s "/bin/sh" -c "git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    su -l vagrant -s "/bin/sh" -c "sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc"
}

install_exa() {
    apt_install exa
    su -l vagrant -s "/bin/sh" -c "echo \"alias ls='exa --icons --group-directories-first'\nalias l='exa -aaghl --icons --group-directories-first'\nalias ll='exa -ghl --icons --group-directories-first'\nalias lt='exa --tree --level=2 --icons --group-directories-first'\" > ~/.aliases.zsh"
    su -l vagrant -s "/bin/sh" -c "echo \"source ~/.aliases.zsh\" >> ~/.zshrc"
}

install_miscellaneous() {
    apt-get update >/dev/null
    apt-get upgrade >/dev/null
    for i in curl git vim gnupg; do
        apt_install "$i"
    done
}

install_mongodb() {
    ## install mongodb-org from mongodb repository
    curl -fsS https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - &>/dev/null
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list >/dev/null
    apt-get update >/dev/null
    apt_install "mongodb-org"
    systemctl start mongod.service
    systemctl enable mongod.service &>/dev/null
}

install_nodejs() {
    apt_install "nodejs"
    apt_install "npm"
}

install_nvm() {
    # su -l vagrant -s "/bin/sh" -c "curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash"
    # su -l vagrant -s "/bin/sh" -c "source ~/.zshrc"
    # # su -l vagrant -s "/bin/sh" -c "nvm install 14.20.0"
    # su -l vagrant -s "/bin/sh" -c "nvm install 16.14.0"

    # su -l vagrant -s "/bin/sh" -c "curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh -o install_nvm.sh; chmod 755 install_nvm.sh; ./install_nvm.sh"

    # install latest nvm
    su -l vagrant -s "/bin/sh" -c "git clone https://github.com/nvm-sh/nvm.git ~/.nvm && cd ~/.nvm && git checkout $(git describe --abbrev=0 --tags)"
    su -l vagrant -s "/bin/sh" -c "source ~/.nvm/nvm.sh"
    su -l vagrant -s "/bin/sh" -c "echo \"source ~/.nvm/nvm.sh\" >> ~/.zshrc"
    su -l vagrant -s "/bin/sh" -c "nvm install 16.14.0"
}

insall_python310() {
    # ...
}

insall_python311() {

}
# insall_nginx() {}
# install_mysql() {}
# install_apache() {}
# install_docker() {}

main() {
    l0g "S T A R T I N G"

    # install basic required packages
    install_miscellaneous

    # install and setup oh-my-zsh
    # install_zsh
    # install_exa

    # install mongoDB
    install_mongodb
    insall_python310
    
    # install nodejs and nvm
    install_nodejs
    install_nvm

    l0g "When first time login via \"vagrant ssh\" choose 2 if the zsh prompt show to the screen!!"
    l0g "T H E   S E R V E R   I S   R E A D Y"
}

main

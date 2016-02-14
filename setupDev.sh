intro_banner() {
  /bin/echo
  /bin/echo "######################"
  /bin/echo "Setup Dev Environment"
  /bin/echo "######################"
  /bin/echo
  /bin/echo "This will install the following software:"
  /bin/echo "[*] Command line tools for Xcode"
  /bin/echo "[*] brew"
  /bin/echo "[*] rbenv"
  /bin/echo "[*] rails"
  /bin/echo "[*] iterm"
  /bin/echo "[*] tmux"
  /bin/echo "[*] zsh"
  /bin/echo "[*] npm"
  /bin/echo "[*] ember-cli"
  /bin/echo "[*] pathogen"
  /bin/echo "[*] pull down good vimrc"
  /bin/echo
  /bin/echo "The installation will be isolated to the $(whoami) account for easy removal."
  /bin/echo
}

confirm() {
  read -p "Are you sure you want to continue? [yes/no] " -n 1 -r
  /bin/echo

  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "Exiting installation..."
    exit 1
  fi

  /bin/echo
}

check_log() {
  # Each step in the setup process can call this to direct user's attention
  # For example:
  # check_log(brew) would return:
  # Brew installation failed check setupDev.log for "Brew Installation"
}

setup() {
  # Install command line tools for Xcode
  /bin/echo "[*] Installing command line tools for Xcode"
  /usr/bin/xcode-select --install 2>> setupDev.log

  # Install Brew
  /bin/echo "[*] Installing Brew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2>> setupDev.log
  /usr/local/bin/brew update 2>> setupDev.log

  # Get homebrew-cask-versions
  /bin/echo "[*] Including homebrew-cask-versions"
  /usr/local/bin/brew tap caskroom/versions 2>> setupDev.log

  # Install iTerm 2-beta
  /bin/echo "[*] Installing iTerm2-beta"
  /usr/local/bin/brew cask install iterm2-beta 2>> setupDev.log

  # Install Tmux
  /bin/echo "[*] Installing Tmux"
  /usr/local/bin/brew install tmux 2>> setupDev.log

  # Install rbenv
  /bin/echo "[*] Installing rbenv with brew"
  /usr/local/bin/brew install rbenv
  /bin/echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

  # Install ruby
  /bin/echo "[*] Installing Ruby 2.3.0"
  /usr/local/bin/rbenv install 2.3.0
  /bin/echo "[*] Setting 2.3.0 as global"
  /usr/local/bin/rbenv global 2.3.0

  # Install rails
  /bin/echo "[*] Installing rails"
  gem install rails
  /usr/local/bin/rbenv rehash

  # Install node and npm
  /bin/echo "[*] Installing node and npm"
  /usr/local/bin/brew install node
  /usr/local/bin/brew install npm

  # Install Chrome
  /bin/echo "[*] Installing Chrome"
  /usr/local/bin/brew cask install google-chrome

  # Install Atom
  /bin/echo "[*] Installing Atom"
  /usr/local/bin/brew cask install atom

  # Install Oh-My-Zsh
  /bin/echo "[*] Installing oh-my-zsh"
  /bin/sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 2>> setupDev.log
}

intro_banner
confirm
setup

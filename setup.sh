#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew detected."
fi

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Updating Homebrew..."
brew update

echo "Installing curl..."
brew install curl

echo "Installing wget..."
brew install wget

echo "Installing telnet..."
brew install telnet

echo "Installing git..."
brew install git

echo "Installing Zsh..."
brew install zsh

echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Oh My Zsh plugins..."
brew install zsh-autosuggestions zsh-syntax-highlighting

# echo "Adding plugins to .zshrc..."
# plugins=(git docker kubectl helm terraform aws ansible python pip brew vi-mode colored-man-pages zsh-autosuggestions zsh-syntax-highlighting)
# for plugin in "${plugins[@]}"; do
#   echo "source $(brew --prefix)/share/$plugin/$plugin.plugin.zsh" >>~/.zshrc
# done

echo "Installing Python..."
brew install python

echo "Installing Java..."
# brew install openjdk@17 # works till version < 17
curl -L https://download.java.net/java/GA/jdk19.0.2/fdb695a9d9064ad6b064dc6df578380c/7/GPL/openjdk-19.0.2_macos-aarch64_bin.tar.gz -o openjdk-19.0.2_macos-aarch64_bin.tar.gz
mkdir -p $HOME/OpenJDK

tar -xf openjdk-19.0.2_macos-aarch64_bin.tar.gz -C $HOME/OpenJDK
export JAVA_HOME=$HOME/OpenJDK/jdk-19.0.2.jdk/Contents/Home
echo $JAVA_HOME
export PATH=$JAVA_HOME/bin:$PATH
echo 'export JAVA_HOME=$HOME/OpenJDK/jdk-19.0.2.jdk/Contents/Home' >> ~/.zshrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.zshrc
source ~/.zshrc


echo "Installing Ruby..."

# Check if GPG is installed, if not, install it via Homebrew
if ! command -v gpg > /dev/null; then
    echo "Installing GPG..."
    brew install gpg
fi

# Install RVM GPG keys
echo "Installing RVM keys..."
command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -

# Install RVM
echo "Installing RVM..."
\curl -sSL https://get.rvm.io | bash -s stable

# Ensure RVM scripts are loaded
echo "Loading RVM..."
source "$HOME/.rvm/scripts/rvm"

brew install openssl@1.1

# Install Ruby 3.1.3
echo "Installing Ruby 3.1.3..."
rvm install 3.1.3 --with-openssl-dir=$(brew --prefix openssl@1.1)
ruby -v

# Set Ruby 3.1.3 as default
echo "Setting Ruby 3.1.3 as default..."
rvm use 3.1.3 --default

# Verify Installation
echo "Verifying Installation..."
ruby_version=$(ruby -v)
if [[ $ruby_version == *3.1.3* ]]; then
    echo "Ruby 3.1.3 was successfully installed!"
else
    echo "Something went wrong with the Ruby installation."
fi



echo "Installing Terraform..."
brew install terraform

echo "Installing Ansible..."
brew install ansible

echo "Installing Docker..."
brew install --cask docker

echo "Installing Google Chrome..."
brew install --cask google-chrome


echo "Installing iTerm2..."
brew install --cask iterm2

echo "Installing Rectangle..."
brew install --cask rectangle


echo "Installing IntelliJ IDEA..."
brew install --cask intellij-idea

echo "Installation complete. You may need to restart your terminal for all changes to take effect."

# For VSCode and/or IntelliJ plugins, it is recommended to install them manually 
# through the IDE's marketplace because these installations often need user 
# input or GUI interaction which can't be automated through a bash script.

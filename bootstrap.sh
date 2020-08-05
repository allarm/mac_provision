#!/usr/bin/env bash

PYTHON_VERSION="3.8.2"
VENV_DIR=".virtualenvs"
VENV_NAME="default"

if ! command -v xcode-select -p &> /dev/null
then
    echo "XCode CLT is not installed. Installing..."
    xcode-select --install
    echo "Exiting for now, restart the script when installation is finished."
else
    echo "XCode CLT is installed."
fi

if ! command -v brew &> /dev/null
then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo "Homebrew is installed."
fi

echo "Installing Python $PYTHON_VERSION..."

brew install pyenv
pyenv init 

PYENV_INIT="$(pyenv init -)"
ZSHRC_PATH=$HOME/.zshrc

grep -qxFs "$PYENV_INIT" $ZSHRC_PATH || echo "$PYENV_INIT" >> $ZSHRC_PATH

source $HOME/.zshrc

pyenv install $PYTHON_VERSION
pyenv versions
pyenv global $PYTHON_VERSION

cd $HOME
mkdir -p $VENV_DIR
cd $VENV_DIR

python3 -m venv $VENV_NAME
source $VENV_NAME/bin/activate

pip install ansible

echo "Bootstraping done. Continue with Ansible..."

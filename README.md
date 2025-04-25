# dotfiles

[[_TOC_]]

**This is a dangerous operation that will override your .zshrc file.** If you value whatever you have, make sure you back it up before running the install.sh script. I Should also mention that this script will change your terminal from the default to zsh. To run `./scripts/install.zsh`. This does not include any of my work dependencies but is instead used to setup a new machine for me.

## Ubuntu 20.04

This will execute a series of child scripts and get your machine setup

```sh
# 1
./scripts/clean.sh

# 2
sudo ./scripts/install_base.sh

# 3
./scripts/install_env.sh

# logout & login
```

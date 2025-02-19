## ArchFamily of Linux OS configs and tweaks:

These instructions work on Manjaro. They will probably work on other ArchBased OSs.

### Graphics for nvidia-powered laptops

#### Windowing systems

For some time now [Wayland](https://wayland.freedesktop.org/) is being recommended more and more,
and with the latest iteration of [KDE](https://kde.org/) (6), it's taking center stage.<br>

Having said that, I found with nvidia and also with intel-only powered laptops, Wayland has all sorts of performance issues connecting
multiple monitors.

Avoid Wayland or revert to Xorg if you run into problems with a config as described above.

#### Drivers

> Note:<br>
> The below is not Wayland compatible, a workaround is to follow the steps below on Xorg then switch to Wayland

- On Manjaro settings Manager, install nvidia and video-linux drivers only.
  ![Manjaro Settings Drivers](resources/manjaro_settings_drivers.jpg "Manjaro Settings Drivers")
- install optimus + optimus-plasma
  - ```zsh
    sudo pacman -S optimus-manager optimus-manager-plasma
    ```
  - reboot
- to switch graphs, we need to offload first and then restart

```zsh
prime-offload && optimus-manager --switch nvidia
```

`prime-offload` will need to be pre-run if you want to launch some utils like the optimus-manager widget.

![Optimus Manager](resources/optimus_manager.jpg "Optimus Manager Settings")

You can configure defaults and other settings for nvidia gpu-powered laptops from the widget.

### Kernel

Always install the **latest** stable kernel.<br>
As your system ages, you may want to leave an `LTS kernel` installed for recovery or troubleshooting purposes.

![Manjaro Settings Kernel](resources/manjaro_settings_kernel.jpg "Manjaro Settings Kernel")

Do not run your system on experimental kernels.

### Tools:

#### General:

You can install these tools all at once with the below command:

```zsh
sudo pacman -S brave-browser gimp code
```

- brave-browser (chrome-based privacy-oriented browser)
- gimp (image editor)
- code-OSS (visual studio code open source)

**Do not log out nor restart, continue to the next section**

#### Dev:

You can install most of these tools all at once with the below command:

```zsh
sudo pacman -S base-devel ruby python git jdk-openjdk openjdk-doc openjdk-src maven docker docker-compose kubectl minikube neovim fzf nvm vim
```

- base-devel
- git
- java
    - OpenJDK. Always use the latest.
    - OpenJDK source
    - OpenJDK documentation
    - To switch among many installed ones:
  ```zsh
      archlinux-java status
     ```
    - To select a version:
  ```zsh
      sudo archlinux-java set java-XX-openjdk
     ```
- maven
- docker
    - configure your docker installation to use **your user** instead of **root**:
  ```zsh
   sudo usermod -a -G docker $USER
  ``` 
- docker-compose
- kubectl
- minikube
- neovim
- fzf:
    - docs: https://github.com/junegunn/fzf
- nvm (node version manager)
    - docs: https://github.com/nvm-sh/nvm
    - add the following to your `.zshrc` file, save the file then close all terminals
  ```shell
  source /usr/share/nvm/init-nvm.sh 
  ```
    - in a new terminal, install `Node.js`. Always use the latest
    ```zsh
     nvm install node --default --latest-npm
  ```
- ruby
    - to avoid using `sudo` we need to configure a `GEM_PATH` that is local to the user, and also configure `bundler`
      to use that path to install gems:
    ```shell
  ```
    - install ruby-json as it is not installed by default in archFamily
    ```shell
    sudo pacman -S ruby-json
  ```
- python

**Do not log out nor restart, continue to the next section**

#### DBs

```zsh
sudo pacman -S postgresql postgresql-docs mariadb
```

- PostgreSQL
    - [setup postgresql in manjaro](https://dev.to/tusharsadhwani/how-to-setup-postgresql-on-manjaro-linux-arch-412l)
- MariaDB
    - [setup mariadb in manjaro](https://idroot.us/install-mariadb-manjaro-21/)

**After installing _-and-_ configuring the databases, restart the computer (probably logging out will do just fine)**

### Tweaks

### useful shell aliases:

> **Note**: listing here all customizations and configurations added to different config files

These are some useful alias of my personal preferences.<br>
Add more here if you fancy explaining what they do / how they help.

In the `.zshrc` file add the following :

```shell
# customization
## alias
alias pac-installed='pacman -Qq | fzf --preview '\''pacman -Qil {}'\'' --layout=reverse --bind '\''enter:execute(pacman -Qil {} | less)'\'''
alias pac-remote='pacman -Slq | fzf --preview '\''pacman -Si {}'\'' --layout=reverse'
alias ll='ls -lah'

## nvm config
source /usr/share/nvm/init-nvm.sh

## ruby gem config
export GEM_HOME=$HOME/.gem
export PATH="$GEM_HOME/ruby/3.0.0/bin:$PATH"

```

- Aliases:
    - `pac-installed` will show a list of all packages installed
    - `pac-list` will show a list of all packages in pacman's remote repositories
    - `ll` will list a directory with extended info displaying sizes in human-readable format
- Config:
    - nvm:
        - initialize nvm to manage different Node.js versions
    - ruby:
        - create a `GEM_HOME` local to the user
        - add the exec path of gems to the path

Close all your terminals or execute the below command on the ones open to apply the changes:

```zsh
 source ~/.zshrc
  ```

####                   
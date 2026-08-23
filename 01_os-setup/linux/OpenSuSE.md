# Developer Machine Setup on OpenSuSE Tumbleweed

# OS Site:

[OpenSuSE](https://www.opensuse.org/)

# 1st Step:

Check the general OS [README.md](../README.md) and the [LinuxCommon.md](LinuxCommon.md)

## A few unsolicited FAQs before starting

### Why OpenSuSE?

It was one of my first OSs in the early-mid 90's (**S.u.S.E.** back then).

But mostly...

Because I like it.

---

# Installation

# OpenSuSE Specific Software:

| OpenSuSe Specific Software | Description                                                                                                                         |
|----------------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| zsh                        | zsh is an extended Bourne shell with many improvements, including some features of Bash, ksh, and tcsh.                             |
| glib thread libraries      | Libraries providing thread support for the GLib library. [Required by IntelliJ in OpenSuSE](../resources/opensuse_lib_missing.jpg). |

## Conventions:

- Steps 0–2 can be run in bash shell.
    - > **After zsh is installed (Section 2), all following scripts are provided for zsh.**
- Replace placeholders like <Your Name> and <your-email@example.com> as needed.
- Some steps require restarting your shell session.

## 0. System update

Docs: [add package repositories](https://en.opensuse.org/SDB:Add_package_repositories)

```shell script
  # add repositories: may need to accept gpg keys
sudo zypper ar -f http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman                 # packman, a classic!
sudo zypper ar -f https://download.opensuse.org/repositories/Java:/Factory/openSUSE_Tumbleweed/ java_factory  # java_factory. Latest versions usually not on the regular repositories
sudo zypper ar -f https://brave-browser-rpm-release.s3.brave.com/x86_64 brave_browser                         # brave browser. 
sudo zypper ar https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo          # NVIDIA Container Toolkit

  # update
sudo zypper dup --details
```

It is possible that a reboot will be necessary depending on the nature of the updates (ie, a kernel update).

In doubt, reboot.

---

## 1. Installation

```shell
# Install some base development patterns
sudo zypper install -t pattern devel_basis devel_C_C++
```

```shell
# Remove vi as we will install neo vim in the next step
 sudo zypper rm vi

# Install as much of the software now and we configure it in later steps
sudo zypper install bash-completion brave-browser btop ca-certificates curl docker docker-compose fastfetch gcc git \
            google-noto-fonts google-noto-sans-cjk-fonts graphviz jq libgthread-2_0-0 make neovim openssl partitionmanager \
            pkgconf ruby ruby-devel tar unzip wget xz zsh zsh-completions zsh-sh
       
# Installing some software from flatpak              
flatpak install com.vscodium.codium 
```

---

## 2. Configuration

All these configs are for your own user, if you switch to SuperUser with `sudo su`, a few things, like the shell or some configuration, will not apply as
`root`.

## 2.1 zsh and Completions

```shell
# set zsh as the default shell (log out/ log in after this step)
chsh -s /usr/bin/zsh
```

From this point onward, use `zsh` for the remaining steps.

---

## 3. Oh My zsh, Powerlevel10k, and Plugins

Install and configure Oh My zsh, Powerlevel10k, zsh-syntax-highlighting, and zsh-autosuggestions.

```shell
# Install Oh My zsh without changing shell or auto-running zsh right now
RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set ZSH_CUSTOM for convenience
export ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install Powerlevel10k theme (recommended method)
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

# Install plugins
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
```

Install `MesloLGS Nerd Font` (the font recommended by Powerlevel10k):

```shell
# Install MesloLGS NF to user fonts
mkdir -p "$HOME/.local/share/fonts"
cd "$HOME/.local/share/fonts"

# Download the four MesloLGS Nerd Font patched TTFs
for f in "MesloLGS NF Regular.ttf" "MesloLGS NF Bold.ttf" "MesloLGS NF Italic.ttf" "MesloLGS NF Bold Italic.ttf"; do
curl -fLO "https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/${f}"
done

# Rebuild font cache (user-level)
fc-cache -fv "$HOME/.local/share/fonts"

# Confirm font is available
fc-list | grep -i "MesloLGS NF" || echo "MesloLGS NF not detected; check downloads."
```

Recommended `~/.zshrc` configuration:

```shell
# modify ~/.zshrc with the below
# most of these options may already be there by oh-my-zsh and powerlevel10k setup 

# Oh My zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Completion init for various commands (docker, node, ...)
autoload -U compinit
compinit

# History: location and size
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

# History: ignore duplicates, and share history file among many sessions
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS SHARE_HISTORY

# Plugins (order matters: keep highlighting last)
plugins=(
  git
  docker docker-compose
  kubectl
  npm node nvm
  ruby bundler gem
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"
```

Apply and configure:

```shell
# Reload zsh to apply
exec zsh -l
# If prompted, run the configuration wizard
p10k configure
```

---

## 4. Git

```shell
# Install git
sudo zypper install git

# Verify
git --version

# Configure your identity
git config --global user.name "<Your Name>"
git config --global user.email "<your-email@example.com>"

# Recommended defaults
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global branch.autosetuprebase never

# test setup
# the above settings should be reflected in the config file
cat ~/.gitconfig
```

---

## 5. Java JDK Latest

Add the Java:Factory repository and install JDK from OpenSuSE packages.

```shell
# Array of Java versions to install
java_versions=("25" "26" "27")

# Install each Java version
for version in "${java_versions[@]}"; do
  sudo zypper install "java-${version}-openjdk" "java-${version}-openjdk-devel" "java-${version}-openjdk-javadoc" "java-${version}-openjdk-src"
done
```

Optional environment variables:

```zsh
# Add to ~/.zshrc to have JAVA_HOME and JAVA_BINDIR explicitly set, as changing with update-alternatives fails to set env vars
# Find the Java binary path
java_bin=$(which java)

# Resolve the symbolic link to get the actual Java installation directory
java_bin_directory=$(dirname $(readlink -f $java_bin))

# Set Java env vars
export JAVA_BINDIR=$java_bin_directory
export JAVA_HOME=$(dirname $java_bin_directory)
```

---

## 6. jq

```shell
# Install jq
sudo zypper install jq
jq --version
```

---

## 7. Node.js via NVM (latest + LTS)

```shell
# Install NVM
export NVM_DIR="$HOME/.nvm"

#look for latest version in github
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | zsh

# Load NVM for current zsh session
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"

# Install Node.js (LTS and current) and set default
nvm install --lts
nvm install node
nvm alias default 'lts/*'
nvm use default

# Verify
node -v
npm -v
corepack enable #unsure: check this
```

Persist NVM in your ~/.zshrc:

```shell
# Add to ~/.zshrc
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"

# above bash completion seems ok also in zsh
```

---

## 8. Libgthread-2 library (libgthread-2)

```shell
# install missing libgthread-2_0-0 required by intelliJ in openSUSE as of early mid 2025
sudo zypper in libgthread-2_0-0

```

---

## 9. Docker and Docker Compose

```shell
# Install Docker and Compose plugin
sudo zypper install docker docker-compose

# Enable and start
sudo systemctl enable --now docker

# Configure non-root docker usage
sudo usermod -aG docker "$USER"

# Apply the new group immediately in the current session or else log-out and log back in
newgrp docker <<'EOF'
docker version
EOF

# Verify images can run
docker run --rm hello-world

# Compose v2
docker compose version
```

zsh completions (optional if not using Oh My zsh’s docker plugin):

```shell
mkdir -p "${ZSH_CUSTOM:-$HOME/.zsh}" 2>/dev/null
docker completion zsh > "${ZSH_CUSTOM:-$HOME/.zsh}/_docker"
```

---

## 10. kubectl (Kubernetes CLI)

```shell
# Install latest stable kubectl
# This overwrites any existing configuration in /etc/zypp/repos.d/kubernetes.repo
cat <<EOF | sudo tee /etc/zypp/repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.33/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.33/rpm/repodata/repomd.xml.key
EOF

# Verify
kubectl version --client
```

zsh completion:

```shell
# System-wide
kubectl completion zsh | sudo tee /usr/local/share/zsh/site-functions/_kubectl >/dev/null
# Or user-local
kubectl completion zsh > "${ZSH_CUSTOM:-$HOME/.zsh}/_kubectl"
```

---

## 11. Minikube (local Kubernetes)

```shell
# Download latest Minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install -m 0755 minikube /usr/local/bin/minikube
rm -f minikube

# Start with Docker driver
minikube start --driver=docker

# Verify cluster
kubectl get nodes
```

zsh completion:

```shell
# System-wide
minikube completion zsh | sudo tee /usr/local/share/zsh/site-functions/_minikube >/dev/null
# Or user-local
minikube completion zsh > "${ZSH_CUSTOM:-$HOME/.zsh}/_minikube"
```

---

## 12. Neovim

```shell
sudo zypper install neovim
nvim --version
```

Optional minimal config:

```shell
mkdir -p ~/.config/nvim
cat > ~/.config/nvim/init.lua <<'EOF'
-- minimal Neovim config
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
EOF
```

---

## 13. Ruby and local gem setup

```shell
# Ruby and headers for native gems
sudo zypper install ruby ruby-devel

# Verify
ruby -v
gem -v

# Configure gems to install into user path and update PATH, "avoiding using sudo"
{
  echo '# Ruby user gems'
  echo 'export GEM_HOME="$HOME/.gem"'
  echo 'export GEM_PATH="$GEM_HOME"'
  echo 'export PATH="$(ruby -e '\''require \"rubygems\"; print Gem.user_dir'\'')/bin:$PATH"'
} >> ~/.zshrc

# Apply for current session
export GEM_HOME="$HOME/.gem"
export GEM_PATH="$GEM_HOME"
export PATH="$GEM_HOME/bin:$PATH"

# Install bundler to user gem path
gem install bundler jekyll 

# Verify bundler
bundler --version
```

---

## 14. Verify everything

```shell
# Git
git --version

# Java
java -version
javac -version

# Node & npm
node -v
npm -v

# Docker & Compose
docker version
docker compose version

# Kubernetes
kubectl version --client
minikube version

# Neovim
nvim --version

# Ruby & bundler
ruby -v
gem -v
bundler -v

# zsh and theme
echo "$SHELL"
echo "$ZSH_THEME"
```

---

## 15. Troubleshooting

- After adding your user to the docker group, log out and back in, or run `newgrp docker` to apply the new group for the current session.
- If NVM isn’t available, ensure its init lines are in your ~/.zshrc file and source it or restart the shell.
- If Powerlevel10k icons look off, make sure you installed a Nerd Font (e.g., MesloLGS NF) and select it in your terminal profile. Once that's done, rerun the
  p10k configuration wizard.

## What's Next:

You can get the project itself from GitHub.

Check the instructions on how to [bootstrap the project](../../02_bootstrap/README.md).   
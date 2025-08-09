# Developer Machine Setup on OpenSuSE

This **README** provides a basic setup for a development workstation on OpenSuSE close to my own (Tumbleweed).

It is intended to be a quick reference for myself mostly between OS installations, but it may be useful for others as well to check what I
install by default.

## WARNING

> What follows heavily modifies your system in a way that may break other software, current installation, or even the entire OS.
>
> Stop here and do not run any script if you do not know what you are doing.
>
> ---
> This **WILL** change your system.

---

## A few FAQs before starting

### Why OpenSuSE?

It was one of my first OSs in the early-mid 90's (**S.u.S.E.** back then).

But mostly...

Because I like it.

### What about other OSs?

I like many of them too, just a little less.

It is ok to use any other *nix OS. The bulk, if not all, of the system codebase and companion tools are not tied to any specific OS.

### OpenSuSE comes with bash as default, why zsh?

I got used to it when running Manjaro and it stuck.

But mostly...

Because I like it.

### What about bash?

I like it too.

### Will this change in time?

Yes, maybe. Definitely! Probably... not... But yes, sure it will! Kinda not thou...

---

# Installation

Here is an overview of the software that will be installed:

Remember this is mostly for myself... a few tools might be lateral to specific project's needs.

## Base Software

| Base Software                                | Description                                                                                |
|----------------------------------------------|--------------------------------------------------------------------------------------------|
| Base development tools (pattern devel_basis) | A set of basic development tools.                                                          |
| gcc family                                   | The GNU Compiler Collection.                                                               |
| make                                         | Build automation tool.                                                                     |
| pkg-config                                   | A helper tool used when compiling applications and libraries.                              |
| glib thread libraries                        | Libraries providing thread support for the GLib library. Required by IntelliJ in OpenSuSE. |
| ---                                          | ---                                                                                        |
| Neovim                                       | Vim-based text editor.                                                                     |
| jq                                           | Command-line JSON processor.                                                               |
| Git                                          | A distributed version control system.                                                      |

## Shell and Tools

| Shell and tools         | Description                                                                                             |
|-------------------------|---------------------------------------------------------------------------------------------------------|
| zsh and completions     | zsh is an extended Bourne shell with many improvements, including some features of Bash, ksh, and tcsh. |
| Oh My zsh               | An open-source, community-driven framework for managing zsh configuration.                              |
| Powerlevel10k           | A theme for zsh that provides a customizable and fast prompt.                                           |
| zsh-syntax-highlighting | A plugin for zsh that provides syntax highlighting in the command line.                                 |
| zsh-autosuggestions     | A plugin for zsh that provides suggestions as you type based on command history.                        |

## Languages and Runtimes

| Languages and Runtimes             | Description                                                                                           |
|------------------------------------|-------------------------------------------------------------------------------------------------------|
| OpenSuSE Java:Factory repositories | Repositories providing Java-related packages for OpenSuSE. Used for `E`arly `A`ccess releases mostly. |
| JDK                                | Latest Java Development Kit `G`eneral `A`vailability version, regardless if it is `LTS` or not.       |                                               
| nvm + latest Node.js               | Node Version Manager (nvm) to manage multiple Node.js versions, with the latest Node.js installed.    |
| Ruby                               | Ruby programming language with gem configuration.                                                     |

## Containerization and Orchestration

| Containerization / Orchestration | Description                                                                  |
|----------------------------------|------------------------------------------------------------------------------|
| Docker                           | A platform for developing, shipping, and running applications in containers. |
| Docker Compose                   | A tool for defining and running multi-container Docker applications.         |
| kubectl                          | A command-line tool for interacting with Kubernetes clusters.                |
| Minikube                         | A tool that runs a single-node Kubernetes cluster locally.                   |

## IDEs

| Containerization / Orchestration | Description                                            |
|----------------------------------|--------------------------------------------------------|
| VS Code                          | Visual Studio Code, a source-code editor by Microsoft. |
| JetBrains IDEs                   | Many IDEs by Jetbrains                                 |

## Conventions:

- Steps 0–2 can be run in your current shell.
    - > **After zsh is installed (Section 2) all following scripts are provided for zsh.**
- Replace placeholders like <Your Name> and <your-email@example.com> as needed.
- Some steps require restarting your shell session.

## 0) System update

```shell script
  # refresh repositories
sudo zypper refresh
sudo zypper update -y
```

---

## 1) Base Development Tools (install first)

Install the base development pattern and essential build/runtime tools.

```shell
  # Install the base development pattern
sudo zypper install -t pattern devel_basis
```

```shell
  # Ensure common build/runtime utilities are present
sudo zypper install gcc gcc-c++ make pkgconf pkgconf-pkg-config curl wget ca-certificates tar unzip xz openssl
```

---

## 2) zsh and Completions (install second)

Install zsh and completions and set it as the default shell.

```shell script
  # Install zsh and bash completions
sudo zypper install  zsh zsh-completions bash-completion
```

```shell
  # set zsh as the default shell (log out/in afterwards)
chsh -s /usr/bin/zsh
```

From this point onward, use zsh for the remaining steps.

---

## 3) Oh My zsh, Powerlevel10k, and Plugins

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
    # most of these option may already be there by oh-my-zsh and powerlevel10k setup 

# Oh My zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Completion
autoload -U compinit
compinit

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
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

# Powerlevel10k instant prompt (optional)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
```

Apply and configure:

```shell
  # Reload zsh to apply
exec zsh -l
# If prompted, run the configuration wizard
p10k configure
```

---

## 4) Git

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
```

---

## 5) Java JDK Latest

Add the Java:Factory repository and install JDK from OpenSuSE packages.

```shell
# Detect OpenSuSE variant to add the proper Java:Factory repository
source /etc/os-release

if [[ "$ID" == "OpenSuSE-tumbleweed" ]]; then
  sudo zypper ar -f https://download.OpenSuSE.org/repositories/Java:/Factory/OpenSuSE_Tumbleweed/ Java_Factory
else
  # For Leap, map VERSION_ID to the repository name. Example for Leap 15.5:
  # OpenSuSE_Leap_15.5 or OpenSuSE_Leap_$VERSION_ID
  sudo zypper ar -f "https://download.OpenSuSE.org/repositories/Java:/Factory/OpenSuSE_Leap_${VERSION_ID}/" Java_Factory
fi

sudo zypper refresh

# Install JDK 24 and development headers. Use the latest GA at the moment of installation.
sudo zypper install java-24-openjdk java-24-openjdk-devel java-24-openjdk-javadoc java-24-openjdk-src

# Verify
java -version
javac -version
```

Optional environment variables:

```shell
# Add to ~/.zshrc if you want JAVA_HOME explicitly set
if [[ -d /usr/lib64/jvm/java-24-openjdk ]]; then
  export JAVA_HOME="/usr/lib64/jvm/java-24-openjdk"
elif [[ -d /usr/lib/jvm/java-24-openjdk ]]; then
  export JAVA_HOME="/usr/lib/jvm/java-24-openjdk"
fi
export PATH="$JAVA_HOME/bin:$PATH"
```

---

## 6) jq

```shell
  # Install jq
sudo zypper install jq
jq --version
```

---

## 7) Node.js via NVM (latest + LTS)

```shell
# Install NVM
export NVM_DIR="$HOME/.nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | zsh

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
corepack enable
```

Persist NVM in your ~/.zshrc:

```shell
# Add to ~/.zshrc
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
```

---

## 8) glib thread library (libgthread-2)

```shell
# Runtime and headers (for compiling against gthread-2.0)
sudo zypper install glib2 glib2-devel

# Confirm pkg-config data
pkg-config --cflags --libs gthread-2.0
```

---

## 9) Docker and Docker Compose

```shell
# Install Docker Engine and Compose plugin
sudo zypper install docker docker-compose docker-compose-switch docker-compose-plugin

# Enable and start
sudo systemctl enable --now docker

# Allow non-root docker usage
sudo usermod -aG docker "$USER"
# Apply the new group immediately in the current session
newgrp docker <<'EOF'
docker version
EOF

# Verify images can run
docker run --rm hello-world

# Compose v2
docker compose version

# Legacy v1 shim (if installed)
docker-compose version
```

zsh completions (optional if not using Oh My zsh’s docker plugin):

```shell
mkdir -p "${ZSH_CUSTOM:-$HOME/.zsh}" 2>/dev/null
docker completion zsh > "${ZSH_CUSTOM:-$HOME/.zsh}/_docker"
```

---

## 10) kubectl (Kubernetes CLI)

```shell
# Install latest stable kubectl
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c -
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

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

## 11) Minikube (local Kubernetes)

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

## 12) Neovim

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

## 13) Ruby and local gem setup

```shell
# Ruby and headers for native gems
sudo zypper install ruby ruby-devel make gcc

# Verify
ruby -v
gem -v

# Configure gems to install into user path and update PATH
{
  echo '# Ruby user gems'
  echo 'export GEM_HOME="$HOME/.gem"'
  echo 'export GEM_PATH="$GEM_HOME"'
  echo 'export PATH="$(ruby -e '\''require \"rubygems\"; print Gem.user_dir'\'')/bin:$PATH"'
} >> ~/.zshrc

# Apply for current session
export GEM_HOME="$HOME/.gem"
export GEM_PATH="$GEM_HOME"
export PATH="$(ruby -e 'require \"rubygems\"; print Gem.user_dir')/bin:$PATH"

# Install bundler to user gem path
gem install --user-install bundler

# Verify bundler
command -v bundler
```

---

## 14) Verify everything

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

## 15) Troubleshooting

- After adding your user to the docker group, log out and back in, or run newgrp docker to apply the new group for the current session.
- If NVM isn’t available, ensure its init lines are in your ~/.zshrc and restart the shell.
- If Powerlevel10k icons look off, install a Nerd Font (e.g., MesloLGS NF) and select it in your terminal profile.
- On corporate networks, set proxy variables before curl/wget operations:
    - export http_proxy="http://<proxy-host>:<port>"
    - export https_proxy="http://<proxy-host>:<port>"

You now have a complete developer environment on OpenSuSE with base tools first, zsh and shell experience configured second, and the rest of the
developer tooling installed on top.

# TO Confirm setup

> This only exists as a commited stash / TODO

---

## 2. Installation from flatpak

```shell
flatpak install com.spotify.Client com.vscodium.codium
```

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

# Configuration of common Software

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
sdkman

---

## 7. Node.js via NVM

```shell
# Install NVM
#look for latest version in github
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | zsh

nvm install node
```

---

---

## 9. Docker and Docker Compose

```shell
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

---

## 13. Ruby and local gem setup

```shell
# Ruby and headers for native gems
sudo zypper install ruby ruby-devel

# Verify
ruby -v
gem -v

# Configure gems to install into user path and update PATH, "avoiding using sudo"
  # Ruby user gems
export GEM_HOME="$HOME/.gem"
export GEM_PATH="$GEM_HOME"
export PATH="$(ruby -e 'require "rubygems"; print Gem.user_dir')/bin:$PATH"
```


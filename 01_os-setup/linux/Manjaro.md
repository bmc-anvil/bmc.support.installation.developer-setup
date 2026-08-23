# Developer Machine Setup on Manjaro

# OS Site:

[Manjaro](https://manjaro.org/)

# 1st Step:

Check the general OS [README.md](../README.md) and the [LinuxCommon.md](LinuxCommon.md)

## A few unsolicited FAQs before starting

### Why Manjaro?

I used [archlinux](https://archlinux.org/) for some time, but installation was a bit more effort than I wanted to invest between distro hops, then... Manjaro.

But mostly...

Because I like it.

---

# Installation

# Manjaro Specific Software:

| Manjaro Specific Software | Description |
|---------------------------|-------------|
| ---                       | ----        |

## 0. System update

```shell
# Update your system
sudo pacman -Syu
```

It is possible that a reboot will be necessary depending on the nature of the updates (ie, a kernel update).

In doubt, reboot.

---

## 1. Installation from Manjaro packages

```shell
sudo pacman -Sv \
base-devel brave-browser btop cmake cmake-extras ctags docker docker-compose \
fzf gcc gcc-libs gdb gimp git go graphviz jq kubectl minikube opencode ruby \
rustup strawberry unzip vlc wl-clipboard yasm zip
```

---


---

## 3. Configuration

---

## What's Next:

You can get the project itself from GitHub.

Check the instructions on how to [bootstrap the project](../../02_bootstrap/README.md).   
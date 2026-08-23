# Developer Machine Setup with Linux

The **READMEs** in this folder provide a basic setup for a development workstation on Linux close to my own (whatever I use at a given moment).

It is intended to be a quick reference for myself mostly between OS installations, but it may be useful for others as well as to check what I install by
default.

These are not a guide on how to install a given distro from scratch or alongside another OS.

## WARNING

> What follows heavily modifies your system in a way that may break other software, current installation, or even the entire OS.
>
> Stop here and do not run any script if you do not know what you are doing, and even if you know, this can harm your system.
>
> ---
> This **WILL** change your system and **MAY** render it unusable.

---

## A few unsolicited FAQs before starting

### Why these distros and not others?

Because I like these a little more.

#### Why Rolling Distros?

I like rolling distros.

This setup is on my personal machine, not a work one.
<br>On a work computer where I can choose... I might choose OpenSuSE Tumbleweed...
<br>I've actually chosen Ubuntu in the past at work because of some business integrations, and... yes... you guessed... Manjaro! (did you guess?!)

### What about other OSs?

I like many of them too, just a little less.

I use many of them too, just a lot less.

It is ok to use any other *nix OS. The bulk, if not all, of the system codebase and companion tools are not tied to any specific OS.

### Why zsh?

I got used to it when running Manjaro and it stuck.

But mostly...

Because I like it.

### What about bash?

I like it too.

### Will this change in time?

Yes, maybe. Definitely! Probably... not... But yes, sure it will! Kinda not thou...

---

# Installation

Here is an overview of the software that will be installed that is common to every distro:

Remember this is mostly for myself... a few tools might be lateral to specific project's needs.

## Base / General Software

| Base Software | Description                                                   |
|---------------|---------------------------------------------------------------|
| jq            | Command-line JSON processor.                                  |
| fzf           | Command-line fuzzy finder.                                    |
| GIMP          | GNU Image Manipulation Program.                               |
| graphviz      | a set of graph drawing tools (backend for mermaid / plantuml) |
| Strawberry    | Music player.                                                 |
| zip / unzip   | Compression / Decompression.                                  |
| Brave         | Web Browser.                                                  |

## Shell and Tools and Fonts

| Shell and tools and Fonts  | Description                                                                                             |
|----------------------------|---------------------------------------------------------------------------------------------------------|
| zsh / zsh completions      | zsh is an extended Bourne shell with many improvements, including some features of Bash, ksh, and tcsh. |
| Oh My zsh                  | An open-source, community-driven framework for managing zsh configuration.                              |
| Powerlevel10k              | A theme for zsh that provides a customizable and fast prompt.                                           |
| zsh-syntax-highlighting    | A plugin for zsh that provides syntax highlighting in the command line.                                 |
| zsh-autosuggestions        | A plugin for zsh that provides suggestions as you type based on command history.                        |
| Meslo nerd fonts           | Shell friendly fonts.                                                                                   |
| fira-code-fonts            | Some developer fonts                                                                                    |
| jetbrains-mono-fonts       | More developer fonts by JetBrains                                                                       |
| google-noto-fonts          | Even more fonts, supporting many languages                                                              |
| google-noto-sans-cjk-fonts | Yes more fonts... **C**hinese **J**apanese and **K**orean                                               |

## Languages and Runtimes and Utilities

| Languages and Runtimes | Description                                                                                        |
|------------------------|----------------------------------------------------------------------------------------------------|
| Base development tools | Each OS has their own basic development package                                                    |
| gcc family C / C++     | The GNU Compiler Collection with C/C++ Langs                                                       |
| gcc libs               | The GNU Compiler Collection.                                                                       |
| gcc utils              | The GNU Compiler Collection.                                                                       |
| gdb                    | The Gnu Debugger                                                                                   |
| Git                    | A distributed version control system.                                                              |
| GoLang                 | Go programming language.                                                                           |
| make                   | Build automation tool.                                                                             |
| cmake                  | Cross platform Build System Generator tool.                                                        |
| cmake-extras           | cmake add-ons                                                                                      |
| JDKs (sdkman!)         | Latest Java Development Kit `General Availability` version, regardless if it is `LTS` or not.      |                                               
| maven (sdkman!)        | java build tool. Required to run scripts before the maven wrapper is downloaded (latest stable)    |                                               
| nvm + latest Node.js   | Node Version Manager (nvm) to manage multiple Node.js versions, with the latest Node.js installed. |
| Ruby et als            | Ruby programming language with gem configuration and some software like jekyll.                    |
| Rust (rustup)          | Rust programming language via rustup tool.                                                         |
| yasm                   | Rewrite of NASM. 80x86 assembler                                                                   |

## Containerization and Orchestration

| Containerization / Orchestration | Description                                                                  |
|----------------------------------|------------------------------------------------------------------------------|
| Docker                           | A platform for developing, shipping, and running applications in containers. |
| Docker Compose                   | A tool for defining and running multi-container Docker applications.         |
| kubectl                          | A command-line tool for interacting with Kubernetes clusters.                |
| Minikube                         | A tool that runs a single-node Kubernetes cluster locally.                   |

## IDEs

| IDEs / text editors | Description                              |
|---------------------|------------------------------------------|
| Vim / Neovim        | Vim / Vim-based text editor.             |
| VS Codium           | Visual Studio Code minus some Microsoft. |
| JetBrains IDEs      | Many IDEs by Jetbrains                   |

## Codecs, Multimedia, etc.

| Codes / Multimedia                  | Description    |
|-------------------------------------|----------------|
| Many codecs not included by default | several codecs |

## AI Related.

| AI                                     | Description                                                                    |
|----------------------------------------|--------------------------------------------------------------------------------|
| Nvidia CUDA                            | Access to GPU compute                                                          |
| Nvidia Toolkit                         | Nvidia toolkit to allow docker access to GPU (used for ollama with open-webui) |
| Ollama                                 | Local LLM                                                                      |
| OpenWebUi                              | Web Based LLM Chat interface                                                   |
| OpenCode                               | CLI Harness (coding agent). Full featured                                      |
| Pi                                     | CLI Harness (coding agent). Minimalistic                                       |
| ---                                    | ---                                                                            |
| Mistral / Llama / Gemma LLM and others | local capable models                                                           |


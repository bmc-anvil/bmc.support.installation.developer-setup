# Developer Setup - Bootstrap

## What

This is the first step in the developer setup.

It is a series of scripts (or just one), links and instructions to get started.

### Assumptions

These setup scripts assume that you have a dev setup already working with all necessary tools already present for a java environment for your
operating system.

There are full setup instructions for [OpenSuSE in the dev setup site]() or as a [plain README.md file here](../os-setup/linux/OpenSuSE.md) if you are interested.

Anything and everything you run from this whole project is at your own risk.<br>
As with any dev effort, these scripts and any other code, instructions, etc... ~~may~~ **definitely will** have bugs.

## Why

Because of maintenance reasons and possible future drifting in technologies, shell scripts are the most "neutral" way to use as a starting point.<br>
The rationale is that some sort of *nix terminal is present on local machines.

I use one of many Linux distributions, mostly OpenSuSE / Manjaro / Arch, which may not match every visitor's setup.<br>
Windows OSs are not, and will not, be supported in the foreseeable future.

A constant, though, is my use of zsh as shell, and the scripts will reflect that.<br>
In time bash adaptation will be probably supported as well or even replacing zsh scripts altogether.

This project is geared towards minimum maintenance, therefore, maintaining more than one single only unique thing of anything is a no no.<br>
(yes... you may see _x_ exception...)

## How

These are the steps to get started, follow them in order:

1. Do **not** clone anything, the scripts will do that.
2. Copy the [scripts folder](bmc-anvil-project) into a selected location on your machine.
    1. That folder will be the root for everything else in the project
    2. Configure the `bmc-anvil-github.env` file your corresponding **GitHub** credentials.
3. Run the following:
    ```shell
        # make the scripts executable
        chmod +x clone_repos.zsh

        # run the script
        ./clone_repos.zsh
    ```
4. The project's structure with all repos should now be cloned
5. Delete the scripts and *.env files.
6. Done.

## What's next

## References

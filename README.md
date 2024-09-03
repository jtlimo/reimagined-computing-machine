# NixOs configuration

## Why NixOs?

I moved from Arch linux machine after a disastrous update of my system, that made me lost everything in my computer. :sad:
I'm searching for a new distro, and NixOs with the idea of reproducible configuration through machines blow my mind, so I start to learn the nix language and how to configure my machine.

## How to run

I'm using [just](https://github.com/casey/just) to simplify the nixos commands.

Basically after change some configuration, I need to run:

```bash
just deploy
```

To see available commands on just:

```bash
just
```

## I lost my machine, or buy another one, how to configure again?

First of all, I need to install NixOs in the machine.
After that, if the machine doesn't have git installed I recommend to use nix-shell to install quickly git to clone this repository.

- create ssh keys, for work and personal accounts (if necessary): use this article for reference: https://dev.to/arnellebalane/setting-up-multiple-github-accounts-the-nicer-way-1m5m
- inside nix-shell clone the repository with this name nixos-config

With the repository in computer, I need to create symlinks, like that:

> symlinking our repository with nixos default config

```bash
sudo ln -s ~/Documents/nixos-config /etc/nixos
```

> symlinking only justfile on home, to allow to use just commands outside the repo directory

```bash
ln -s ~/Documents/nixos-config/justfile justfile
```

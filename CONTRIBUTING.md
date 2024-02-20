# How to develop

## Setup

1. Install [Nix](https://nixos.org/) package manager, with [this](https://github.com/DeterminateSystems/nix-installer) or enabling [Flakes](https://nixos.wiki/wiki/Flakes) by yourself
1. Install [direnv](https://github.com/direnv/direnv)
1. Clone this repository and `direnv allow` in the directory
1. You can use development tools

```console
> nix develop
(prepared bash)
> task
...
```

## Trouble shooting in docker container

nixos container basically does not have basic unix tools, but installing them is easy as follows

```bash
docker compose up -d
docker exec -it lishogi-devenv-shoginet-1 bash
cat /etc/hosts
nix-shell --packages iputils netcat httpie
ping lila
nc -vz lila 9663
http lila:9663
```

# lishogi-devenv

[![CI - Nix Status](https://github.com/kachick/lishogi-devenv/actions/workflows/ci-nix.yml/badge.svg?branch=main)](https://github.com/kachick/lishogi-devenv/actions/workflows/ci-nix.yml?query=branch%3Amain+)

Setup environments to run or develop [WandererXII/lishogi](https://github.com/WandererXII/lishogi) on your local

## Usage

1. Install [Nix](https://nixos.org/) package manager and [Docker](https://www.docker.com/) with yourself
1. Open 3 terminals and do following sections

### Terminal A - Data Store, etc - Docker

```bash
git clone git@github.com:kachick/lishogi-devenv.git
cd lishogi-devenv
docker compose up
```

### Terminal B - lila and UI - Nix

1. Login to dev shell with current directory as cloned repository
   ```bash
   git clone git@github.com:WandererXII/lishogi.git
   cd lishogi
   # Try this version if you have any problems running head.
   # `git checkout a664c1909115b3f5fd427f510d1634335d0b2c1d`
   nix develop github:kachick/lishogi-devenv
   ```
1. After this, you can run commands in terminal C that written as in [lila setup documents](https://github.com/lichess-org/lila/wiki/Lichess-Development-Onboarding)
   1. `ui/build`
   1. `./lila` # Entered in sbt console
   1. [lila] $ `compile`
   1. [lila] $ `run`
1. Open [localhost:9663](http://localhost:9663/)

### Terminal C - Shogi AI - Nix

1. Login to dev shell with current directory as cloned repository
   ```bash
   git clone https://github.com/WandererXII/shoginet.git
   cd shoginet
   # Try this version if you have any problems running head.
   # `git checkout 9d2d5244b5de9e1076deb04d598c4efc13ac6d21`
   nix develop github:kachick/lishogi-devenv
   ```
1. (Optional) Compile engines yourself the way it is written in [shoginet](https://github.com/WandererXII/shoginet/blob/main/README.md?plain=1#L7-L27)
   ```bash
   ./build-yaneuraou.sh
   ./build-fairy.sh
   git status # you may see updated binaries
   ```
1. (Optional) Test updated binaries or included prebuilt binaries in the repo.
   1. `./YaneuraOu-by-gcc` # Entered in YaneuraOu console
   1. `usi` # returns "usiok"
   1. `isready` # returns "readyok"
   1. `bench` # Make sure it looks working
   1. `fairy-stockfish-largeboard_x86-64` # Entered in Fairy-Stockfish console
   1. `usi` # returns "usiok"
   1. `isready` # returns "readyok"
   1. `bench` # Make sure it looks working
1. `python3 ./shoginet.py` with `endpoint = http://localhost:9663/shoginet/` in the shoginet.ini

## Motivation and concept

I want similar solution like [lichess-org/lila-docker](https://github.com/lichess-org/lila-docker) in lishogi, but I couldn't find anything.\
So started this project, I want to prefer nix as much as possible instead of docker way.

In this repo, set up the dependencies with nix and flake, except for data stores like MongoDB and Redis.\
Back-end like MongoDB and Redis, Websocket will run in containers.

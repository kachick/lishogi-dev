# lishogi-devenv

[![CI - Nix Status](https://github.com/kachick/lishogi-devenv/actions/workflows/ci-nix.yml/badge.svg?branch=main)](https://github.com/kachick/lishogi-devenv/actions/workflows/ci-nix.yml?query=branch%3Amain+)

Setup environments to run and/or develop [WandererXII/lishogi](https://github.com/WandererXII/lishogi) on your local

## Usage

1. Install [Nix](https://github.com/DeterminateSystems/nix-installer), [Docker](https://www.docker.com/) and [direnv](https://github.com/direnv/direnv)
1. Open 2 terminals and do following sections

### Terminal A - Setup and run MongoDB, Redis, lila-ws(websocket), shoginet(AI)

```bash
git clone git@github.com:kachick/lishogi-devenv.git
cd lishogi-devenv
direnv allow
./setup.bash
docker compose up
```

`docker compose up -d` can suppress the logs in the current terminal, but it is recommended to keep the logs in sight.

### Terminal B - lila and UI - Nix

You can run commands that written as in [lila setup documents](https://github.com/lichess-org/lila/wiki/Lichess-Development-Onboarding) with [nix devshell](flake.nix)

```console
cd ./repos
nix develop github:kachick/lishogi-devenv
ui/build
./lila # Entered in sbt console
[lila] $ compile
[lila] $ run
```

### Happy Shogi!

Open [localhost:9663](http://localhost:9663/) in your web browser

## FAQ

Q. Broken behavaior after upstream changes\
A. Update this repository to follow upstream, or run [`./pin_repos.bash`](pin_repos.bash)

Q. How to update this repo?\
A. Additional notes may be found in [CONTRIBUTING.md](CONTRIBUTING.md)

## Motivation and concept

I want similar solution like [lichess-org/lila-docker](https://github.com/lichess-org/lila-docker) in lishogi, but I couldn't find anything.\
So started this project, I want to prefer nix as much as possible instead of docker way.

In this repo

- Setting up the coding dependencies with nix and flake
- Back-end will run in containers

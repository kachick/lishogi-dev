# lishogi-devenv

[![CI - Nix Status](https://github.com/kachick/lishogi-devenv/actions/workflows/ci-nix.yml/badge.svg?branch=main)](https://github.com/kachick/lishogi-devenv/actions/workflows/ci-nix.yml?query=branch%3Amain+)

Setup environments to run or develop [WandererXII/lishogi](https://github.com/WandererXII/lishogi) on your local

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

1. Login to dev shell with current directory as cloned repository
   ```bash
   git clone git@github.com:WandererXII/lishogi.git
   cd lishogi
   # Try this version if you have any problems running head.
   # `git checkout a664c1909115b3f5fd427f510d1634335d0b2c1d`
   nix develop github:kachick/lishogi-devenv
   ```
1. After this, you can run commands that written as in [lila setup documents](https://github.com/lichess-org/lila/wiki/Lichess-Development-Onboarding)
   1. `ui/build`
   1. `./lila` # Entered in sbt console
   1. [lila] $ `compile`
   1. [lila] $ `run`
1. Open [localhost:9663](http://localhost:9663/)

## Motivation and concept

I want similar solution like [lichess-org/lila-docker](https://github.com/lichess-org/lila-docker) in lishogi, but I couldn't find anything.\
So started this project, I want to prefer nix as much as possible instead of docker way.

In this repo

- Setting up the coding dependencies with nix and flake
- Back-end will run in containers

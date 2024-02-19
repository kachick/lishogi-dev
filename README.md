# lishogi-devenv

[![CI - Nix Status](https://github.com/kachick/lishogi-devenv/actions/workflows/ci-nix.yml/badge.svg?branch=main)](https://github.com/kachick/lishogi-devenv/actions/workflows/ci-nix.yml?query=branch%3Amain+)

Setup environments to run or develop [WandererXII/lishogi](https://github.com/WandererXII/lishogi) on your local

## Usage

1. Open your 3 terminals
1. In terminal A: `nix run kachick:lishogi-devenv#mongo`
1. In terminal B: `nix run kachick:lishogi-devenv#redis`
1. In terminal C:
   ```bash
   git clone https://github.com/WandererXII/lishogi.git
   cd lishogi
   # Try this version of lishogi if you have any problems running head.
   # `git checkout 8ccc283ae2841eb1601189ff272bfcf3fa951c2a`
   nix develop kachick:lishogi-devenv
   ```
1. After this, you can run commands in terminal C that written as in [lila setup documents](https://github.com/lichess-org/lila/wiki/Lichess-Development-Onboarding)
   1. `ui/build`
   1. `./lila` # Entered in sbt console
   1. [lila] $ `compile`
   1. [lila] $ `run`
1. Open [localhost:9663](http://localhost:9663/)

## Motivation and concept

I want similar solution like [lichess-org/lila-docker](https://github.com/lichess-org/lila-docker) in lishogi, but I couldn't find anything.\
So started this project, I want to prefer nix as much as possible instead of docker way.

In this repo, set up the dependencies with nix and flake, except for data stores like MongoDB and Redis.
Mongo and Redis will run in a container, but it will not use docker and docker-compose, it will only use [sylabs/singularity](https://github.com/sylabs/singularity) for that.

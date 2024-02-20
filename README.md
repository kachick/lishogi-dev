# lishogi-dev

[![CI - Nix Status](https://github.com/kachick/lishogi-dev/actions/workflows/ci-nix.yml/badge.svg?branch=main)](https://github.com/kachick/lishogi-dev/actions/workflows/ci-nix.yml?query=branch%3Amain+)

Set up environments to run [lishogi.org](https://lishogi.org/) and [develop](https://github.com/WandererXII/lishogi) on your local

## Usage

1. Install [Nix](https://github.com/DeterminateSystems/nix-installer), [Docker](https://www.docker.com/) and [direnv](https://github.com/direnv/direnv)
1. Open 2 terminals and do following sections

### Terminal A - Setup and run MongoDB, Redis, lila-ws(websocket), shoginet(AI)

```bash
git clone git@github.com:kachick/lishogi-dev.git
cd lishogi-dev
direnv allow
task setup
docker compose up
```

- `docker compose up -d` can suppress the logs in the current terminal, but it is recommended to keep the logs in sight.
- `task prepare_db` may improve performance with creating index

### Terminal B - lila and UI - Nix

You can run commands that written as in [lila setup documents](https://github.com/lichess-org/lila/wiki/Lichess-Development-Onboarding) with [nix devshell](flake.nix)

```bash
cd lishogi-dev/repos/lishogi
nix develop github:kachick/lishogi-dev#lila
ui/build
./lila # Enter in sbt console
```

```console
[lila] $ compile
[lila] $ run
...
```

### Happy Shogi!

Open [localhost:9663](http://localhost:9663/) in your web browser

## FAQ

Q. Broken behavaior after upstream changes\
A. Update this repository to follow upstream, or run `task pin`

Q. How to update this repo?\
A. Additional notes may be found in [CONTRIBUTING.md](CONTRIBUTING.md)

## Motivation and concept

When I wanted a solution similar to [lichess-org/lila-docker](https://github.com/lichess-org/lila-docker) in lishogi, I couldn't find an overall solution.\
So I started this project. I prefer nix as possible rather than docker except for simple back-ends like databases.

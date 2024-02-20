# lishogi-dev

[![CI - Nix Status](https://github.com/kachick/lishogi-dev/actions/workflows/ci-nix.yml/badge.svg?branch=main)](https://github.com/kachick/lishogi-dev/actions/workflows/ci-nix.yml?query=branch%3Amain+)

Set up environments to run [lishogi.org](https://lishogi.org/) and [develop](https://github.com/WandererXII/lishogi) on your local

## Usage

Install [Nix](https://github.com/DeterminateSystems/nix-installer), [Docker](https://www.docker.com/) and [direnv](https://github.com/direnv/direnv)

```bash
git clone git@github.com:kachick/lishogi-dev.git
cd lishogi-dev
direnv allow
task setup
docker compose up --detach # MongoDB, Redis, lila-ws(websocket), shoginet(engine)
# You can check the back-end logs via `docker compose logs [service-name]`
task prepare_db
```

```bash
cd repos/lishogi
nix develop ../#lila # Enter in Nix dev shell, with nodejs, sbt
./ui/build
./lila # Enter in sbt console
```

```console
[lila] $ compile
[lila] $ run
...
```

Open [localhost:9663](http://localhost:9663/) in your web browser

If you want to stop the services

```console
[lila] $ exit
cd ../../
$ docker compose down
...
```

_Happy Shogi!_

## FAQ

Q. Broken behavaior after upstream changes\
A. Update this repository to follow upstream, or run `task pin`

Q. How to update this repo?\
A. Additional notes may be found in [CONTRIBUTING.md](CONTRIBUTING.md)

## Motivation and concept

When I wanted a solution similar to [lichess-org/lila-docker](https://github.com/lichess-org/lila-docker) in lishogi, I couldn't find an overall solution.\
So I started this project. I prefer nix as possible rather than docker except for simple back-ends like databases.

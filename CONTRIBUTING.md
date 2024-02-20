# How to develop

## Setup

1. Install [Nix](https://nixos.org/) package manager
2. Allow [Flakes](https://nixos.wiki/wiki/Flakes)
3. Run dev shell as one of the following
   - with [direnv](https://github.com/direnv/direnv): `direnv allow`
   - nix only: `nix develop`
4. You can use development tools

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
ping HOSTMACHINE_IP_BY_hostname-I
nc -vz HOSTMACHINE_IP_BY_hostname-I 9663
http HOSTMACHINE_IP_BY_hostname-I:9663
```

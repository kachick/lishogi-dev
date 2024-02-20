FROM nixos/nix:2.20.2 AS builder

WORKDIR /product

RUN nix-channel --update

RUN nix-env -iA nixpkgs.gcc nixpkgs.gnumake
COPY ["./repos/shoginet/build-yaneuraou.sh", "./repos/shoginet/build-fairy.sh", "./"]
RUN ./build-yaneuraou.sh && ./build-fairy.sh

FROM nixos/nix:2.20.2 AS runner

COPY ./repos/shoginet/ /shoginet/
COPY ./conf/shoginet.ini /shoginet
COPY --from=builder /product /product

RUN nix-channel --update

RUN nix-env -iA nixpkgs.python3 nixpkgs.python3Packages.requests

WORKDIR /shoginet

RUN cp -rf ./eval /product/eval/

ENTRYPOINT nix-shell --packages python3Packages.requests --run "python3 shoginet.py"


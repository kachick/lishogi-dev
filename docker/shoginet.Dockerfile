FROM nixos/nix:2.20.2 AS builder

WORKDIR /product

RUN nix-channel --update

RUN nix-env -iA nixpkgs.gcc nixpkgs.gnumake nixpkgs.git
COPY ["./repos/shoginet/scripts/fairy.sh", "./"]
RUN mkdir -p engines && ./fairy.sh

FROM nixos/nix:2.20.2 AS runner

WORKDIR /shoginet

RUN nix-channel --update

RUN nix-env -iA nixpkgs.nodejs_22 nixpkgs.yaneuraou

COPY ./repos/shoginet/ /shoginet/
COPY ./conf/shoginet.json /shoginet/config/local.json
COPY --from=builder /product/engines/fairy-stockfish /shoginet/engines/fairy-stockfish

RUN npm ci || npm install

ENTRYPOINT ["npm", "run", "start"]


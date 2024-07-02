FROM docker/alpine-tar-zstd:latest as builder
WORKDIR /root

COPY ./localnet/chain-state/alice /root/alice
COPY ./localnet/chain-state/bob /root/bob
COPY ./scripts/specs/local.json /root/local_spec.json

# Compress the /root folder containing the chain state and spec file
# to build a smaller image
RUN tar --use-compress-program=zstd -cvf /root.tar.zst /root

# Describe the final image
FROM opentensor/subtensor:latest
WORKDIR /root
EXPOSE 9944

RUN apt update && apt install zstd tar netcat -y && apt clean

# Copy necessary files
COPY --from=builder /root.tar.zst /root/root.tar.zst
COPY ./localnet/entrypoint.sh /root/entrypoint.sh

RUN chmod +x /root/entrypoint.sh

CMD ["/root/entrypoint.sh"]

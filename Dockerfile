ARG BASE_ARCH=amd64
FROM ${BASE_ARCH}/rust:latest as builder

LABEL maintainer="buddyspencer@protonmail.com"

WORKDIR /
# Clone feather and compile it
RUN git clone https://github.com/feather-rs/feather.git \
    && cd feather && cargo build --release

FROM ${BASE_ARCH}/debian:buster-slim

COPY --from=builder /feather/target/release/feather-server /bin/

VOLUME ["/opt/feather"]

WORKDIR /opt/feather/

CMD ["feather-server"]

EXPOSE 25565

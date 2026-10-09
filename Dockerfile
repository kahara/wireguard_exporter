FROM golang:1.26.1-trixie AS build

RUN mkdir /workdir
COPY go.* /workdir/
COPY *.go /workdir/
RUN echo
COPY ./cmd/wireguard-exporter/main.go /workdir/cmd/wireguard-exporter/main.go

RUN ls -alt /workdir

RUN cd /workdir/cmd/wireguard-exporter && \
    go build .

FROM gcr.io/distroless/base-debian13 AS production

COPY --from=build /workdir/cmd/wireguard-exporter/wireguard-exporter /

CMD ["/wireguard-exporter"]

FROM golang:1.19.3-alpine3.16 as build
RUN apk add --no-cache --update git make
RUN mkdir /build
WORKDIR /build
COPY . .
RUN make build

FROM alpine:3.16.3
RUN apk add --no-cache --update bash curl ca-certificates
COPY --from=build /build/bin/script_exporter /bin/script_exporter
EXPOSE 9469
ENTRYPOINT  [ "/bin/script_exporter" ]

FROM golang:1.9-alpine as builder
WORKDIR /go/src/github.com/andrewb3000/telsocket
RUN mkdir /dist
COPY . .
RUN apk update && apk add --no-cache ca-certificates && update-ca-certificates
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /dist/telsocket-linux-x86 .

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /dist/telsocket-linux-x86 /bin/telsocket
ENV PATH=/bin

ENTRYPOINT ["/bin/telsocket"]

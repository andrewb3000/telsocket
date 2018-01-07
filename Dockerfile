FROM golang:1.9 as builder
WORKDIR /go/src/github.com/flanl/telsocket
RUN mkdir /dist
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /dist/telsocket-linux-x86 .

FROM scratch
COPY --from=builder /dist/telsocket-linux-x86 /bin/telsocket
ENV PATH=/bin

ENTRYPOINT ["/bin/telsocket"]
